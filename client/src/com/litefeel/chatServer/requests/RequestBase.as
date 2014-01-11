package com.litefeel.chatServer.requests
{
	import flash.utils.ByteArray;

	public class RequestBase
	{
		protected var by:ByteArray;
		
		public function RequestBase(head:int, type:int)
		{
			by = new ByteArray();
			by.writeByte(head);
			by.writeByte(type);
		}
		
		public function toByteArray():ByteArray { return by; }
	}
}