package com.litefeel.chatServer.handler
{
	import com.netease.protobuf.ReadUtils;
	import flash.utils.ByteArray;
	

	public class Wrapper
	{
		public var header:int;
		public var action:int;
		public var bytes:ByteArray;
		
		public function Wrapper(bytes:ByteArray)
		{
			bytes.position = 0;
			ReadUtils.read$TYPE_UINT32(bytes); // read tag
			this.header = ReadUtils.read$TYPE_INT32(bytes); // read value
			ReadUtils.read$TYPE_UINT32(bytes); // read tag
			this.action = ReadUtils.read$TYPE_INT32(bytes); // read value
//			var m:SimpleResponder = new SimpleResponder();
//			var m:LoginOKResponder = new LoginOKResponder();
//			m.mergeFrom(bytes);
//			header = m.head;
//			action = m.type;
//			readHeader(bytes);
//			ReadUtils.skip(bytes, WireType.VARINT);
//			this.header = ReadUtils.read$TYPE_INT32(bytes);
//			ReadUtils.skip(bytes, WireType.VARINT);
//			this.action = ReadUtils.read$TYPE_INT32(bytes);
			this.bytes = bytes;
			bytes.position = 0;
		}
		
		
	}
}