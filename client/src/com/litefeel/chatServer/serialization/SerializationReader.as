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
		public static const typeReadFunList:Array = [readDel, readNull, readTrue, readFalse, readByte, readInt, readFloat, readString, readArray, readObject, readBytes];
		
		public static function readDel(bytes:ByteArray):void { throw new Error("Serialization 不应该出现DEL!"); }
		public static function readNull(bytes:ByteArray):Object { return null; }
		public static function readTrue(bytes:ByteArray):Boolean { return true; }
		public static function readFalse(bytes:ByteArray):Boolean { return false; }
		
		public static function readByte(bytes:ByteArray):int { return bytes.readByte(); }
		public static function readInt(bytes:ByteArray):int { return bytes.readInt(); }
		public static function readFloat(bytes:ByteArray):Number { return bytes.readFloat(); }
		public static function readString(bytes:ByteArray):String { return bytes.readUTF(); }
		public static function readBytes(bytes:ByteArray):ByteArray
		{
			var len:int = bytes.readInt();
			var by:ByteArray = new ByteArray();
			bytes.readBytes(by, 0, len);
			return by;
		}
		
		private static function readBoolForArray(bytes:ByteArray):Boolean
		{
			return bytes.readByte() != 0;
		}
		
		public static function readArray(bytes:ByteArray):Array
		{
			var size:int = bytes.readInt();
			var arr:Array = new Array(size);
			var type:int = bytes.readByte();
			var fun:Function = typeReadFunList[type];
			// 数组的bool值为0和1
			if(DataType.TRUE == type || DataType.FALSE == type)
			{
				fun == readBoolForArray;
			}
			for(var i:int = 0; i < size; i++)
			{
				arr[i] = fun(bytes);
			}
			return arr;
		}
		public static function readObject(bytes:ByteArray):Object
		{
			var className:String = bytes.readUTF();
			var ref:Class = className ? flash.net.getClassByAlias(className) : null;
			var o:Object = ref ? new ref() : {};
			
			var key:String = bytes.readUTF();
			while(key)
			{
				o[key] = read(bytes);
				key = bytes.readUTF();
			}
			return o;
		}
		
		public static function read(bytes:ByteArray):*
		{
			var type:int = bytes.readByte();
			var fun:Function = typeReadFunList[type];
			return fun(bytes);
		}
	}
}