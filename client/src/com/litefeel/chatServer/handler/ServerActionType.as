package com.litefeel.chatServer.handler
{
	final public class ServerActionType
	{
		public static const LOGIN_OK:int = 1;	// login ok
		public static const LOGIN_KO:int = 2;	// login ko
		public static const ZONE_MSG:int = 3;	// public message
		public static const PUB_MSG:int = 4;	// public message
		public static const PRI_MSG:int = 5;	// private message
		public static const ROOM_LIST:int = 6; // room list arrival
		public static const USER_JOIN:int = 7; // one user jion this room
		public static const JOIN_ROOM:int = 8; // join this room OK
		public static const USER_LEAVE:int = 9; // user leave this room
		public static const LEAVE_ROOM:int = 10; // leave this room
		public static const UPDATE_POS:int = 11; // an user update position {x,y,vx,vy}
		public static const UPDATE_USER_VAR:int = 12;
		public static const HEART_BEAT:int = 13; // 心跳
	}
}