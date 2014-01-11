package com.litefeel.chatServer.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lite3
	 */
	public class CSEvent extends Event 
	{
		/**
		 * 链接
		 * success:Boolean
		 */
		public static const CONNECTION:String = "connection";
		
		/**
		 * 链接断开
		 */
		public static const CONNECTION_LOST:String = "connectionLost";
		
		/**
		 * 登陆成功
		 * 这里应返回登陆后的一些信息
		 */
		public static const LOGIN:String = "login";
		
		/**
		 * 登陆失败
		 * errorMessage:String 
		 */
		public static const LOGIN_ERROR:String = "loginError";
		
		/**
		 * 私聊消息
		 * message:String
		 * senderId:String
		 * senderName:String
		 */
		public static const PRIVATE_MESSAGE:String = "privateMessage";
		
		/**
		 * 公共消息
		 * message:String
		 * sender:User
		 * room:Room
		 */
		public static const PUBLIC_MESSAGE:String = "publicMessage";
		
		/**
		 * 系统消息
		 * message:String
		 */
		public static const SYSTEM_MESSAGE:String = "systemMessage";
		
		/**
		 * 房间列表已获取到
		 */
		public static const ROOM_LIST:String = "roomList";
		
		/**
		 * 用户进入房间
		 * user:User
		 * room:Room
		 */
		public static const USER_ENTER_ROOM:String = "userEnterRoom";
		
		/**
		 * 用户离开房间
		 * user:User
		 * room:Room
		 */
		public static const USER_EXIT_ROOM:String = "userExitRoom";
		
		/**
		 * 进入房间
		 * room:Room
		 */
		public static const JOIN_ROOM:String = "joinRoom";
		
		/**
		 * 离开房间
		 * room:Room
		 */
		public static const LEAVE_ROOM:String = "leaveRoom";
		
		/**
		 * 用户离开房间
		 * user:User
		 * postion:Position
		 * room:SceneRoom
		 */
		public static const POSTION_UPDATE:String = "postionUpdate";
		
		/**
		 * 用户变量更新
		 * user:User
		 * room:Room
		 * changeList:Array<String> 改变的key列表
		 */
		public static const USER_VARS_UPDATE:String = "userVarUpdate"
		
		
		public var params:Object;
		
		public function CSEvent(type:String, params:Object) 
		{ 
			super(type);
			this.params = params;
		} 
		
		public override function clone():Event 
		{ 
			return new CSEvent(type, params);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CSEvent", "type", "params"); 
		}
		
	}
	
}