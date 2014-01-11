package com.litefeel.chatServer.handler
{
	import com.litefeel.chatServer.ChatServer;
	import com.litefeel.chatServer.data.Position;
	import com.litefeel.chatServer.data.Room;
	import com.litefeel.chatServer.data.SceneRoom;
	import com.litefeel.chatServer.data.User;
	import com.litefeel.chatServer.events.CSEvent;
	import com.litefeel.chatServer.ns.CS;
	import com.litefeel.chatServer.requests.GetRoomListRequest;
	import com.litefeel.chatServer.requests.HeartbeatRequest;
	import com.litefeel.chatServer.requests.UserVar;
	import com.litefeel.chatServer.requests.UserVarOpType;
	import com.litefeel.chatServer.responders.JoinRoomResponder;
	import com.litefeel.chatServer.responders.LeaveRoomResponder;
	import com.litefeel.chatServer.responders.LoginKOResponder;
	import com.litefeel.chatServer.responders.LoginOKResponder;
	import com.litefeel.chatServer.responders.PrivateMessageResponder;
	import com.litefeel.chatServer.responders.PublicMessageResponder;
	import com.litefeel.chatServer.responders.RoomListResponder;
	import com.litefeel.chatServer.responders.UpdatePosResponder;
	import com.litefeel.chatServer.responders.UpdateUserVarResponder;
	import com.litefeel.chatServer.responders.UserJoinResponder;
	import com.litefeel.chatServer.responders.UserLeaveResponder;
	import com.litefeel.chatServer.responders.UserVo;
	import flash.utils.ByteArray;
	

	/**
	 * ...
	 * @author lite3
	 */
	public class SystemHandler
	{
		
		private var handlerMap:Array;
		private var chatServer:ChatServer;
		
		public function SystemHandler(chatServer:ChatServer) 
		{
			this.chatServer = chatServer;
			
			handlerMap = [];
			handlerMap[ServerActionType.HEART_BEAT] = heartBeatHandler;
			handlerMap[ServerActionType.UPDATE_USER_VAR] = updateUserVarHandler;
			handlerMap[ServerActionType.UPDATE_POS] = updatePosHandler;
			handlerMap[ServerActionType.LEAVE_ROOM] = leaveRoomHandler;
			handlerMap[ServerActionType.USER_LEAVE] = userLeaveHandler;
			handlerMap[ServerActionType.JOIN_ROOM] = joinRoomHandler;
			handlerMap[ServerActionType.USER_JOIN] = userJoinHandler;
			handlerMap[ServerActionType.ROOM_LIST] = roomListArrivalHandler;
			handlerMap[ServerActionType.PRI_MSG]   = privateMessageHandler;
			handlerMap[ServerActionType.PUB_MSG]   = publicMessageHandler;
			handlerMap[ServerActionType.LOGIN_KO] = loginKoHandler;
			handlerMap[ServerActionType.LOGIN_OK] = loginOkHandler;
			
			//handlerMap[ServerActionType] = loginOutHandler;
			
			handlerMap["sys"]   = systemMessageHandler;
		}
		
		public function handler(action:int, bytes:ByteArray):void
		{
			trace("hander action:", action);
			var fun:Function = handlerMap[action];
			fun(bytes);
		}
		
		private function loginOkHandler(bytes:ByteArray):void
		{
			var responder:LoginOKResponder = new LoginOKResponder();
			responder.mergeFrom(bytes);
			chatServer.myId = responder.id;
			chatServer.myName = responder.name;
			
			chatServer.sendRequest(new GetRoomListRequest());
			dispatchEvent(CSEvent.LOGIN, { } );
		}
		
		private function loginKoHandler(bytes:ByteArray):void
		{
			var responder:LoginKOResponder = new LoginKOResponder();
			responder.mergeFrom(bytes);
			
			dispatchEvent(CSEvent.LOGIN_ERROR, { errorMessage:responder.error } );
		}
		
		private function loginOutHandler():void
		{
			
		}
		
		private function publicMessageHandler(bytes:ByteArray):void
		{
			var responder:PublicMessageResponder = new PublicMessageResponder();
			responder.mergeFrom(bytes);
			
			var r:Room = chatServer.getRoom(responder.roomId);
			if(!r) return;
			var u:User = r.getUser(responder.userId);
			if (!u) return;
			
			dispatchEvent(CSEvent.PUBLIC_MESSAGE,
				{ sender:u, room:r, message:responder.msg } );
		}
		
		private function privateMessageHandler(bytes:ByteArray):void
		{
			var responder:PrivateMessageResponder = new PrivateMessageResponder();
			responder.mergeFrom(bytes);
			
			dispatchEvent(CSEvent.PRIVATE_MESSAGE,
				{ senderId:responder.userId, senderName:responder.userName, message:responder.msg } );
		}
		
		private function systemMessageHandler(data:*):void
		{
			dispatchEvent(CSEvent.SYSTEM_MESSAGE, { message:data } );
		}
		
		private function roomListArrivalHandler(bytes:ByteArray):void
		{
			var responder:RoomListResponder = new RoomListResponder();
			responder.mergeFrom(bytes);
			
			var idList:Array = responder.idList;
			var nameList:Array = responder.nameList;
			var len:int = idList.length;
			chatServer.roomList.length = len;
			for(var i:int = 0; i < len; i++)
			{
				chatServer.roomList[i] = new SceneRoom(idList[i], nameList[i]);
			}
			
			dispatchEvent(CSEvent.ROOM_LIST, null);
		}
		
		private function joinRoomHandler(bytes:ByteArray):void
		{
			var responder:JoinRoomResponder = new JoinRoomResponder();
			responder.mergeFrom(bytes);
			
			chatServer.myRoomId = responder.roomId;
			var r:Room = chatServer.getRoom(responder.roomId);
			var list:Array = responder.userList;
			var len:int = list.length;
			r.userList.length = 0;
			for(var i:int = 0; i < len; i++)
			{
				var u:User = new User(list[i].uid, list[i].name);
				var varsLen:int = list[i].varList.length;
				for(var j:int = 0; j < varsLen; j++)
				{
					var uv:UserVar = list[i].varList[j];
					u.vars.setBytes(uv.key, uv.value);
				}
				var posList:Array = list[i].posList;
				if(u.uid == chatServer.myId) u.CS::setChatServer(chatServer);
				r.addUser(u);
				if(r is SceneRoom)
				{
					SceneRoom(r).updateUserPos(u.uid, posList[0], posList[1], posList[2], posList[3], posList[4]);
				}
			}
			dispatchEvent(CSEvent.JOIN_ROOM, { room:r } );
		}
		
		private function leaveRoomHandler(bytes:ByteArray):void
		{
			var responder:LeaveRoomResponder = new LeaveRoomResponder();
			responder.mergeFrom(bytes);
			
			var r:Room = chatServer.getRoom(responder.roomId);
			if (!r) return;
			var u:User = r.removeUser(chatServer.myId);
			if (!u) return;
			chatServer.myRoomId = -1;
			
			dispatchEvent(CSEvent.LEAVE_ROOM, { room:r } );
		}
		
		private function userJoinHandler(bytes:ByteArray):void
		{
			var responder:UserJoinResponder = new UserJoinResponder();
			responder.mergeFrom(bytes);
			
			var protoUser:UserVo = responder.user;
			var u:User = new User(protoUser.uid, protoUser.name);
			var len:int = protoUser.varList.length;
			for(var i:int = 0; i < len; i++)
			{
				var uv:UserVar = protoUser.varList[i];
				u.vars.setBytes(uv.key, uv.value);
			}
			
			var r:Room = chatServer.getRoom(responder.roomId);
			r.addUser(u);
			
			if(r is SceneRoom)
			{
				var posList:Array = protoUser.posList;
				SceneRoom(r).updateUserPos(u.uid, posList[0], posList[1], posList[2], posList[3], posList[4]);
			}
			
			dispatchEvent(CSEvent.USER_ENTER_ROOM, { user:u, room:r } );
		}
		
		private function userLeaveHandler(bytes:ByteArray):void
		{
			var responder:UserLeaveResponder = new UserLeaveResponder();
			responder.mergeFrom(bytes);
			
			var r:Room = chatServer.getRoom(responder.roomId);
			var u:User = r.removeUser(responder.userId);
			dispatchEvent(CSEvent.USER_EXIT_ROOM, { user:u, room:r } );
		}
		
		private function updatePosHandler(bytes:ByteArray):void
		{
			var responder:UpdatePosResponder = new UpdatePosResponder();
			responder.mergeFrom(bytes);
			
			var r:SceneRoom = chatServer.getRoom(responder.roomId) as SceneRoom;
			if(!r) return;
			
			var pos:Position = r.getUserPos(responder.userId);
			if(!pos) return;
			
			var u:User = r.getUser(responder.userId);
			
			var arr:Array = responder.posList;
			// x, y, vx, vy, time
			pos.update(arr[0], arr[1], arr[2], arr[3], arr[4]);
			
			dispatchEvent(CSEvent.POSTION_UPDATE, { user:u, position:pos, room:r } );
		}
		
		private function updateUserVarHandler(bytes:ByteArray):void
		{
			var responder:UpdateUserVarResponder = new UpdateUserVarResponder();
			responder.mergeFrom(bytes);
			
			var r:Room = chatServer.getRoom(responder.roomId);
			if(!r) return;
			
			var u:User = r.getUser(responder.userId);
			if(!u) return;
			
			var keyList:Array = [];
			var len:int = responder.varList.length;
			for(var i:int = 0; i < len; i++)
			{
				var uv:UserVar = responder.varList[i];
				if(UserVarOpType.DELETE == uv.op)
				{
					u.vars.delVar(uv.key);
				}else
				{
					u.vars.setBytes(uv.key, uv.value);
				}
				keyList[i] = uv.key;
			}
			
			dispatchEvent(CSEvent.USER_VARS_UPDATE, { user:u, room:r, changeList:keyList } );
		}
		
		private function heartBeatHandler(bytes:ByteArray):void
		{
			chatServer.sendRequest(new HeartbeatRequest());
		}
		
		[Inline]
		private final function dispatchEvent(type:String, params:Object):void 
		{
			chatServer.dispatchEvent(new CSEvent(type, params));
		}
	}
}