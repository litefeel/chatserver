package com.litefeel.game.module.chat 
{
	import com.litefeel.chatServer.ChatServer;
	import com.litefeel.chatServer.data.User;
	import com.litefeel.chatServer.events.CSEvent;
	import com.litefeel.chatServer.requests.PublicMessageRequest;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author lite3
	 */
	public class ChatBox extends ChatBoxUI 
	{
		private var server:ChatServer;
		
		public function ChatBox(server:ChatServer) 
		{
			super();
			
			this.server = server;
			server.addEventListener(CSEvent.PUBLIC_MESSAGE, pubMsgHandler);
			server.addEventListener(CSEvent.CONNECTION, serverStateHandler);
			server.addEventListener(CSEvent.CONNECTION_LOST, serverStateHandler);
			server.addEventListener(CSEvent.LOGIN, serverStateHandler);
			server.addEventListener(CSEvent.LOGIN_ERROR, serverStateHandler);
			
			
			input.addEventListener(KeyboardEvent.KEY_UP, sendMsgHandler);
		}
		
		private function serverStateHandler(e:CSEvent):void 
		{
			switch(e.type)
			{
				case CSEvent.CONNECTION : appendText("连接成功！"); break;
				case CSEvent.CONNECTION_LOST : appendText("连接丢失！"); break;
				case CSEvent.LOGIN : appendText("登陆成功！"); break;
				case CSEvent.LOGIN_ERROR : appendText("登陆失败：\n" + e.params.errorMessage); break;
			}
		}
		
		private function sendMsgHandler(e:KeyboardEvent):void 
		{
			if (!server.connected && e.keyCode == 13)
			{
				server.connect();
			}
			if (e.keyCode == 13 && input.text)
			{
				var msg:PublicMessageRequest = new PublicMessageRequest();
				msg.msg = input.text;
				msg.roomId = server.myRoomId;
				server.sendRequest(msg);
			}
		}
		
		private function pubMsgHandler(e:CSEvent):void 
		{
			var u:User = User(e.params.sender);
			var name:String = u.isMy ? "你" : u.name;
			showMsg(name, e.params.message);
		}
		
		private function showMsg(userName:String, msg:String):void
		{
			appendText("[" + userName + "] " + msg);
		}
	}

}