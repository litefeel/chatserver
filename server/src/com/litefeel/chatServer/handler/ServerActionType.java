package com.litefeel.chatServer.handler;

public class ServerActionType {

	public static final byte LOGIN_OK = 1;	// login ok
	public static final byte LOGIN_KO = 2;	// login ko
	public static final byte ZONE_MSG = 3;	// zone message
	public static final byte PUB_MSG = 4;	// public message
	public static final byte PRI_MSG = 5;	// private message
	public static final byte ROOM_LIST = 6; // send room list
	public static final byte USER_JOIN = 7; // one user jion this room
	public static final byte JOIN_ROOM = 8; // join this room OK
	public static final byte USER_LEAVE = 9; // user leave this room
	public static final byte LEAVE_ROOM = 10; // leave this room
	public static final byte UPDATE_POS = 11; // the user update position {x,y,vx,vy}
	public static final byte UPDATE_USER_VAR = 12; // the user update position {x,y,vx,vy}
	public static final byte HEAD_BEAT = 13; // the user update position {x,y,vx,vy}
}
