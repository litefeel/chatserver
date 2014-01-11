package com.litefeel.chatServer.serialization
{
	import com.litefeel.chatServer.data.DataType;
	
	import flash.net.getClassByAlias;
	import flash.utils.ByteArray;

	public class SerializationReader
	{
		public static const DEL:int = 0;
		public static const NULL:int = 1;
		public static const TRUE:int = 2;
		public static const FALSE:int = 3;
		public static const BYTE:int = 4;
		public static const INT:int = 5;
		public static const FLOAT:int = 6;
		public static const STR:int = 7;
		public static const ARRAY:int = 8;
		public static const OBJECT:int = 9;
		public static const BYTES:int = 10;
		public static const typewriteFunList:Array = [readDel, readNull, readTrue, readFalse, readByte, readInt, readFloat, readString, readArray, readObject, readBytes];
		
		public static function writeDel(bytes:ByteArray):void { bytes.writeByte(DataType.DEL); }
		public static function writeNull(bytes:ByteArray):void { bytes.writeByte(DataType.NULL); }
		public static function writeTrue(bytes:ByteArray):void { bytes.writeByte(DataType.TRUE); }
		public static function writeFalse(bytes:ByteArray):void { bytes.writeByte(DataType.FALSE); }
		public static function writeBool(bytes:ByteArray, b:Boolean):void
		{
			bytes.writeByte(b ? DataType.TRUE : DataType.FALSE);
		}
		
		public static function writeByte(bytes:ByteArray, n:int):void
		{
			bytes.writeByte(DataType.BYTE);
			bytes.writeByte(n);
		}
		public static function writeInt(bytes:ByteArray, n:int):void
		{
			bytes.writeByte(DataType.INT);
			bytes.writeInt(n);
		}
		public static function writeFloat(bytes:ByteArray, n:Number):void
		{
			bytes.writeByte(DataType.FLOAT);
			bytes.writeFloat(n);
		}
		public static function writeString(bytes:ByteArray, s:String):String
		{
			bytes.writeByte(DataType.STR);
			bytes.writeUTF(s);
		}
		public static function writeBytes(bytes:ByteArray, by:ByteArray, offset:uint = 0, len:uint = 0):ByteArray
		{
			bytes.writeByte(DataType.BYTES);
			var byLen:int = by.length;
			if(offset > byLen) offset = byLen;
			if(0 == len) len = byLen - offset;
			else if(len > byLen - offset) len = byLen - offset;
			
			bytes.writeInt(len);
			bytes.writeBytes(by, offset, len);
		}
		/**
		 * 
		 * @param bytes
		 * @param arr
		 * @param elementType 参见DataType, true|false时自动使用bool值
		 * @param elementClass 当为指定类型的时候才使用
		 * 
		 */		
		public static function writeArray(bytes:ByteArray, arr:Array, elementType:int, elementClass:Class = null):void
		{
			bytes.writeByte(DataType.ARRAY);
			var size:int = arr.length;
			bytes.writeInt(size);
			bytes.writeByte(elementType);
			
			if(DataType.NULL == elementType)
			{
				bytes.writeByte(DataType.NULL);
				return;
			}
			
			
			var type:int = bytes.writeByte();
			var fun:Function = typewriteFunList[type];
			for(var i:int = 0; i < size; i++)
			{
				arr[i] = fun(bytes);
			}
			return arr;
		}
		public static function writeObject(bytes:ByteArray, o:Object):void
		{
			var className:String = bytes.writeUTF();
			var ref:Class = className ? flash.net.getClassByAlias(className) : null;
			var o:Object = ref ? new ref() : {};
			
			var key:String = bytes.writeUTF();
			while(key)
			{
				o[key] = write(bytes);
				key = bytes.writeUTF();
			}
			return o;
		}
		
		public static function write(bytes:ByteArray):*
		{
			var type:int = bytes.writeByte();
			var fun:Function = typewriteFunList[type];
			return fun(bytes);
		}
	}
}