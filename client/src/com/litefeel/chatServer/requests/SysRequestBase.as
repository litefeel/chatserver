package com.litefeel.chatServer.requests
{
	import com.litefeel.chatServer.handler.HeaderType;
	
	import flash.utils.ByteArray;

	public class SysRequestBase extends RequestBase
	{
		public function SysRequestBase(type:int)
		{
			super(HeaderType.SYS, type);
		}
	}
}