package com.litefeel.chatServer.handler
{
	public class ClientActionType
	{
		public static const LOGIN:int = 1;
		public static const LOGOUT:int = 2;
		public static const ZONE_MSG:int = 3;
		public static const PUB_MSG:int = 4;	// public message
		public static const PRI_MSG:int = 5;	// private message
		public static const GET_ROOM_LIST:int = 6;
		public static const JOIN_ROOM:int = 7;
		public static const LEAVE_ROOM:int = 8;
		public static const UPDATE_POS:int = 9; // update user postion {x,y,vx,vy}
		public static const UPDATE_USER_VAR:int = 10;
		public static const HEART_BEAT:int = 11; // 心跳包
	}
}