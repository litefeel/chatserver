package com.litefeel.chatServer.data
{
	import flash.utils.ByteArray;
	

	
	public class UserVars
	{
		
		private var bytesMap:Object = {};
		private var varMap:Object = {};
		private var typeMap:Object = {};
		
		
		public function getBoolen(k:String):Boolean {
			var bytes:ByteArray = bytesMap[k];
			return bytes && bytes[0] != 0;
		}
		
		public function setBoolen(k:String, v:Boolean):void {
			var bytes:ByteArray = bytesMap[k];
			if(!bytes) bytes = bytesMap[k] = new ByteArray();
			bytes.position = bytes.length = 0;
			bytes.writeBoolean(v);
		}
		
		public function getInt(k:String):int {
			var bytes:ByteArray = bytesMap[k];
			if(!bytes) return 0;
			bytes.position = bytes.length = 0;
			return bytes.readInt();
		}
		
		public function setInt(k:String, v:int):void {
			var bytes:ByteArray = bytesMap[k];
			if(!bytes) bytes = bytesMap[k] = new ByteArray();
			bytes.position = bytes.length = 0;
			bytes.writeInt(v);
		}
		
		public function getString(k:String):String {
			var bytes:ByteArray = bytesMap[k];
			if(!bytes) return null;
			bytes.position = bytes.length = 0;
			return bytes.readUTF();
		}
		
		public function setString(k:String, v:String):void {
			var bytes:ByteArray = bytesMap[k];
			if(!bytes) bytes = bytesMap[k] = new ByteArray();
			bytes.position = bytes.length = 0;
			bytes.writeUTF(v);
		}
		
		public function getBytes(k:String):ByteArray {
			return bytesMap[k];
		}
		
		public function setBytes(k:String, v:ByteArray):void
		{
			bytesMap[k] = v;
		}
		
		public function delVar(k:String):void
		{
			delete varMap[k];
			delete typeMap[k];
		}
		
//		public function toBytes():ByteArray {
//			var bytes:ByteArray = new ByteArray();
//			for(var k:String in typeMap)
//			{
//				bytes.writeByte(typeMap[k]);
//				bytes.writeUTF(k);
//				switch(typeMap[k])
//				{
//					case DataType.BOOL : bytes.writeBoolean(varMap[k]); break
//					case DataType.INT  : bytes.writeInt(varMap[k]); break;
//					case DataType.STR  : bytes.writeUTF(varMap[k]); break;
//				}
//			
//			}
//			return bytes;
//		}
//		
//		/**
//		 * 
//		 * @param bytes
//		 * @param offset
//		 * @param len 长度 ,-1表示bytes.length
//		 * @return 
//		 */		
//		public static function fromBytes(bytes:ByteArray, offset:uint, len:uint):UserVars
//		{
//			var vars:UserVars = new UserVars();
//			var oldPos:uint = bytes.position;
//			if(len > bytes.length - offset) len = bytes.length - offset;
//			var end:uint = offset + len;
//			bytes.position = offset;
//			while(bytes.position < end)
//			{
//				switch(bytes.readByte())
//				{
//					case DataType.BOOL : vars.setBoolen(bytes.readUTF(), bytes.readBoolean()); break;
//					case DataType.INT  : vars.setInt(bytes.readUTF(), bytes.readInt()); break;
//					case DataType.STR  : vars.setString(bytes.readUTF(), bytes.readUTF()); break;
//				}
//			}
//			bytes.position = oldPos;
//			return vars;
//		}
	}
}