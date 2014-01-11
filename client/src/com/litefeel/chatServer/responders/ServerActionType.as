package com.litefeel.chatServer.responders {
	public final class ServerActionType {
		public static const LOGIN_OK:int = 1;
		public static const LOGIN_KO:int = 2;
		public static const ZONE_MSG:int = 3;
		public static const PUB_MSG:int = 4;
		public static const PRI_MSG:int = 5;
		public static const ROOM_LIST:int = 6;
		public static const USER_JOIN:int = 7;
		public static const JOIN_ROOM:int = 8;
		public static const USER_LEAVE:int = 9;
		public static const LEAVE_ROOM:int = 10;
		public static const UPDATE_POS:int = 11;
		public static const UPDATE_USER_VAR:int = 12;
		public static const HEART_BEAT:int = 13;
	}
}
