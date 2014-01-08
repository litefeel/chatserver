package com.litefeel.chatServer.handler;

public class ClientActionType {
	
	public static final byte LOGIN = 1;
	public static final byte LOGOUT = 2;
	public static final byte ZONE_MSG = 3;	// zone message
	public static final byte PUB_MSG = 4;	// public message
	public static final byte PRI_MSG = 5;	// private message
	public static final byte GET_ROOM_LIST = 6; // get room list;
	public static final byte JOIN_ROOM = 7;
	public static final byte LEAVE_ROOM = 8;
	public static final byte UPDATE_POS = 9; // update user postion {x,y,vx,vy}
	public static final byte UPDATE_USER_VAR = 10; // update user postion {x,y,vx,vy}
	public static final byte HEAD_BEAT = 11; // update user postion {x,y,vx,vy}
}
