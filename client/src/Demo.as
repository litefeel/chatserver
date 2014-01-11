package  
{
	import com.litefeel.chatServer.ChatServer;
	import com.litefeel.chatServer.events.CSEvent;
	import com.litefeel.chatServer.requests.JoinRoomRequest;
	import com.litefeel.chatServer.requests.LoginRequest;
	import com.litefeel.game.module.chat.ChatBox;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	
	
	/**
	 * ...
	 * @author lite3
	 */
	public class Demo extends Sprite 
	{
		
		
		private var chatBox:ChatBox;
		
		private var chatServer:ChatServer;
		
		public function Demo() 
		{
			if (stage) init(null)
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			chatServer = new ChatServer();
			initUI();
			chatServer.addEventListener(CSEvent.CONNECTION, connectionHandler);
			chatServer.addEventListener(CSEvent.ROOM_LIST, roomListHandler);
			
			chatServer.host = "127.0.0.1";
			chatServer.port = 5000;
			chatServer.connect();
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler(null);
		}
		
		private function connectionHandler(e:CSEvent):void 
		{
			var req:LoginRequest = new LoginRequest();
			req.userId = "lite3" + Math.random();
			req.pw = req.userId;
			chatServer.sendRequest(req);
		}
		
		private function roomListHandler(e:CSEvent):void 
		{
			// 加入第一个房间
			var request:JoinRoomRequest = new JoinRoomRequest();
			request.roomId = chatServer.roomList[0].id;
			chatServer.sendRequest(request);
		}
		
		private function initUI():void 
		{
			chatBox = new ChatBox(chatServer);
			chatBox.y = stage.stageHeight;
			addChild(chatBox);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function resizeHandler(e:Event):void 
		{
			chatBox.y = stage.stageHeight;
		}
	}

}