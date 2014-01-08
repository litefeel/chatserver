package com.litefeel.chatServer.data;

import java.util.ArrayList;
import java.util.HashMap;

public class Zone {

	// 刚登陆,没有进去房间的用户map
	private HashMap<String, User> onlineUserMap;
	// 刚登陆,没有进去房间的用户map
	private HashMap<String, User> freeUserMap;
	private ArrayList<Room> roomList;
	
	
	public Zone()
	{
		onlineUserMap = new HashMap<String, User>();
		freeUserMap = new HashMap<String, User>();
		roomList = new ArrayList<Room>();
	}
	
	public Room getRoom(int id)
	{
		if(id<=0 || id > roomList.size()) return null;
		return roomList.get(id-1);
	}
	
	public ArrayList<Room> getRoomList()
	{
		return roomList;
	}
	
	public boolean joinRoom(User u, int roomId)
	{
		Room r = getRoom(roomId);
		if(null == r) return false;
			
		User tmp = freeUserMap.get(u.uid);
		if(tmp != null)
		{
			u = tmp;
			freeUserMap.remove(u.uid);
		}
		
		return r.addUser(u);
	}

	public void addRoom(Room r)
	{
		roomList.add(r);
	}
	
	public Room removeUserFromRoom(User u, int rid)
	{
		Room r = getRoom(rid);
		if(null == r) return null;
		User user = r.removeUser(u);
		if(null == user) return null;
		
		if(0 == u.getRoomCount())
		{
			freeUserMap.put(user.uid, user);
		}
		return r;
	}

	public void login(User u) {
		User old = onlineUserMap.get(u.uid);
		if(old != null) {
			old.thread.destroy();
		}
		onlineUserMap.put(u.uid, u);
		freeUserMap.put(u.uid, u);
	}
	
	public void logout(String uid) {
		onlineUserMap.remove(uid);
		freeUserMap.remove(uid);
	}
	
	public User getUser(String uid) {
		User u = freeUserMap.get(uid);
		if(u != null) return u;
		
		for(Room r : roomList) {
			u = r.getUser(uid);
			if(u != null) return u;
		}
		return null;
	}
	
	synchronized
	public User[] getOnlineUserList() {
		User[] list = new User[onlineUserMap.size()];
		int i = 0;
		for(User u : onlineUserMap.values()) {
			list[i++] = u;
		}
		return list;
	}
	
	public int getOnlineUserCount() {
		return onlineUserMap.size();
	}

	public void sendAll(byte[] bytes) {
		for(User u : onlineUserMap.values()) {
			u.thread.send(bytes);
		}
	}
}
