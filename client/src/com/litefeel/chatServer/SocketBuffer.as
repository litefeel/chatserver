package com.litefeel.chatServer
{
	import com.litefeel.chatServer.handler.Wrapper;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class SocketBuffer
	{
		private var buffer:ByteArray;
		private var bufferEnd:uint = 0;
		private var dataLen:uint;
		
		public function SocketBuffer()
		{
			buffer = new ByteArray();
		}
		
		public function get bytesAvailable():uint { return buffer.bytesAvailable; }
		
		public function readWrapper():Wrapper
		{
			if(0 == dataLen && buffer.bytesAvailable >= 4)
			{
				dataLen = buffer.readInt();
			}
			
			if(dataLen != 0 && buffer.bytesAvailable >= dataLen)
			{
				var by:ByteArray = new ByteArray();
				by.writeBytes(buffer, buffer.position, dataLen);
				trace("数据包:", dataLen + 4);
				Debug.showBytes(by);
				var wreapper:Wrapper = new Wrapper(by);
				buffer.position += dataLen;
				dataLen = 0;
				return wreapper;
			}
			return null;
		}
		
		public function write(socket:Socket):void
		{
			var len:uint = socket.bytesAvailable;
			socket.readBytes(buffer, bufferEnd, len);
			bufferEnd += len;
		}
	}
}