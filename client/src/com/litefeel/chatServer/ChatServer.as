package com.litefeel.chatServer
{
	import com.litefeel.chatServer.data.Room;
	import com.litefeel.chatServer.events.CSEvent;
	import com.litefeel.chatServer.handler.SystemHandler;
	import com.litefeel.chatServer.handler.Wrapper;
	import com.netease.protobuf.Message;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	

	/**
	 * ...
	 * @author lite3
	 */
	public class ChatServer extends EventDispatcher
	{
		//public var onConnection:Function;		// 链接				function (obj:Object); target:ChatServer, success:Boolean
		//public var onConnectLost:Function;		// 链接断开			function (obj:Object); target:ChatServer
		//public var onLogin:Function;			// 登陆				function (obj:Object); target:ChatServer, success:Boolean, error:String(如果登录不成功)
		//public var onLoginOut:Function;			// 登陆				function (obj:Object); target:ChatServer
		//public var onPrivateMessage:Function;	// 私聊消息			function (obj:Object); target:ChatServer, message:String, uid:String, userName:String
		//public var onPublicMessage:Function;	// 公共消息			function (obj:Object); target:ChatServer, message:String, user:User, room:Room
		//public var onSystemMessage:Function;	// 系统消息			function (obj:Object); target:ChatServer, message:String
		//public var onRoomList:Function;			// 房间列表已获取到	function (obj:Object); target:ChatServer
		//public var onUserJoin:Function;			// 用户进入房间 	function (obj:Object); target:ChatServer, user:User, room:Room
		//public var onUserLeave:Function;		// 用户离开房间		function (obj:Object); target:ChatServer, user:User
		//public var onJoinRoom:Function;			// 进入房间			function (obj:Object); target:ChatServer, room:Room
		//public var onLeaveRoom:Function;		// 离开房间			function (obj:Object); target:ChatServer, room:Room
		//public var onUpdatePos:Function;		// 用户离开房间		function (obj:Object); target:ChatServer, user:User, pos:Position, room:SceneRoom
		//public var onUpdateUserVar:Function;	// 用户变量更新		function (obj:Object); target:ChatServer, user:User, room:Room, key:String
		
		public var host:String;
		public var port:int;
		
		public var myId:String;
		public var myName:String;
		
		public var myRoomId:int;
		
		public const roomList:Vector.<Room> = new Vector.<Room>();
		
		private const output:ByteArray = new ByteArray();
		
		public function getRoom(id:int):Room
		{
			for(var i:int = roomList.length - 1; i >= 0; i--)
			{
				if(roomList[i].id == id) return roomList[i];
			}
			return null;
		}
		
		private var buffer:SocketBuffer;
		private var dataLen:uint;
		
		
		
		private var _connected:Boolean = false;
		
		private var sysHandler:SystemHandler;
		private var socket:Socket;
		
		public function ChatServer() 
		{
			sysHandler = new SystemHandler(this);
			buffer = new SocketBuffer();
			
			_connected = false;
			socket = new Socket();
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(Event.CLOSE, closeHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
//			socket.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function get connected():Boolean { return _connected; }
		
		
		/**
		 * 连接 
		 * @param address
		 * @param port
		 */		
		public function connect():void
		{
			if (!_connected && host && port > 0)
			{
				Debug.show("链接中....");
				try {
					socket.connect(host, port);
				}catch (err:Error)
				{
					Debug.show("不能连接");
				}
			}
		}
		
		/** 断开链接 */
		public function disconnect():void
		{
			_connected = false;
			socket.close();
			dispatchEvent(new CSEvent(CSEvent.CONNECTION_LOST, null));
		}
		
		/**
		 * 更新位置信息,可能移动该方法到SceneRoom里
		 * @param x
		 * @param y
		 * @param vx
		 * @param vy
		 * @param time 更新的时间,有可能不使用,而是由chatServer获取时间
		 */		
//		public function updatePos(x:Number, y:Number, vx:Number, vy:Number, time:Number):void
//		{
//			var bytes:ByteArray = new ByteArray();
//			bytes.writeFloat(x);
//			bytes.writeFloat(y);
//			bytes.writeFloat(vx);
//			bytes.writeFloat(vy);
//			bytes.writeFloat(time);
//			sendBytes(HeaderType.SYS, ClientActionType.UPDATE_POS, bytes);
//		}
		
		public function sendRequest(request:Message):void
		{
			output.position = 0;
			request.writeTo(output);
			//const bytes:ByteArray = new ByteArray();
			socket.writeInt(output.position);
			socket.writeBytes(output, 0, output.position);
			socket.flush();
		}
		
		/**
		 * 发送数据
		 * @private
		 * @param	header	表示头 一般为 "sys"
		 * @param	action	表示动作
		 * @param	message	要传送的数据
		 */
//		private function sendObj(header:int, action:int, message:Object):void
//		{
//			var msg:String = JSON.stringify(message);
//			var by:ByteArray = new ByteArray();
//			by.writeUTFBytes(msg);
//			socket.writeInt(by.length+2);
//			socket.writeByte(header);
//			socket.writeByte(action);
//			socket.writeBytes(by, 0, by.length);
//			socket.flush();
//		}
		
//		private function sendBytes(header:int, action:int, bytes:ByteArray):void
//		{
//			socket.writeInt(bytes.length + 2);
//			socket.writeByte(header);
//			socket.writeByte(action);
//			socket.writeBytes(bytes, 0, 0);
//			socket.flush();
//		}
		
		
		//----------------- event -------------------------------
		
		private function connectHandler(e:Event):void
		{
			_connected = true;
			Debug.loggerEnabled = false;
			Debug.show("链接成功!");
//			socket.writeUTFBytes("<policy-file-xxquest/>");
//			socket.flush();
			
			dispatchEvent(new CSEvent(CSEvent.CONNECTION, null));
		}
		
		private function closeHandler(e:Event):void
		{
			_connected = false;
			Debug.loggerEnabled = false;
			Debug.show("链接丢失!");
			dispatchEvent(new CSEvent(CSEvent.CONNECTION_LOST, null));
		}
		
		private function dataHandler(e:ProgressEvent):void
		{
			Debug.loggerEnabled = false;
			Debug.show("有数据来了:");
			
			buffer.write(socket);
			
			var wrapper:Wrapper = buffer.readWrapper();
			while(wrapper)
			{
				sysHandler.handler(wrapper.action, wrapper.bytes);
				wrapper = buffer.readWrapper();
			}
			
		}
		
		private function errorHandler(e:IOErrorEvent):void 
		{
			
		}
	}
}