package com.litefeel.chatServer.data;

import java.util.ArrayList;

import com.litefeel.chatServer.Connection;


public class User
{
	
	private UserVars vars = null;
	
	private int lastRoomId = -1;
	private ArrayList<Integer> roomList = new ArrayList<Integer>();
	
	/** 是否可以说话 */
	private boolean canSay = true;
	
	/** 用户名 */
	public String uid;
	/** 昵称 */
	public String name;
	/** 绑定的服务线程  */
	public Connection thread;
	
	public UserVars getVars() {
		return vars;
	}
	
	public int getLassRoomId()
	{
		return lastRoomId;
	}
	
	public int getRoomCount()
	{
		return roomList.size();
	}
	
	public int[] getRoomList()
	{
		int len = roomList.size();
		int[] arr = new int[len];
		for(int i = 0; i < len; i++)
		{
			arr[i] = roomList.get(i);
		}
		return arr;
	}
	
	public void addedRoom(int rid)
	{
		if(roomList.indexOf(rid) < 0)
		{
			lastRoomId = rid;
			roomList.add(rid);
		}
	}
	
	public void removeRoom(int rid)
	{
		if(roomList.indexOf(rid) < 0) return;
		roomList.remove(Integer.valueOf(rid));
		int len = roomList.size();
		lastRoomId = 0 == len ? -1 : roomList.get(len-1);
	}
	
	public void removeAllRoom()
	{
		lastRoomId = -1;
		roomList.clear();
	}
	
	public User(String uid, String name, Connection thread)
	{
		this.uid = uid;
		this.name = name;
		this.thread = thread;
		vars = new UserVars();
	}
	
	public boolean getCanSay()
	{
		return canSay;
	}
	
	public void setCanSay(boolean canSay)
	{
		if(this.canSay != canSay)
		{
			this.canSay = canSay;
		}
	}
}
