package com.litefeel.chatServer.data;

import java.util.HashMap;

public class Room
{
	
	private int	id;
	private String name;
	
	private HashMap<String, User> userMap;
	
	public Room()
	{
		userMap = new HashMap<String, User>();
	}
	
	public HashMap<String, User> getUserMap()
	{
		return userMap;
	}
	
	public int getUserCount()
	{
		return userMap.size();
	}
	
	
	/**
	 * 添加一个用户
	 * @param user
	 */
	public boolean addUser(User user)
	{
		User old = userMap.get(user.uid);
		if(old == user) return false;
		
		// 已经有个这个用户
		if(old != null)
		{
			old.thread.destroy();
		}
		
		userMap.put(user.uid, user);
		user.addedRoom(id);
		return true;
	}
	
	public User getUser(String uid)
	{
		return userMap.get(uid);
	}
	
	/**
	 * 移除一个用户
	 * @param user
	 */
	public User removeUser(User user)
	{
		user.removeRoom(id);
		return userMap.remove(user.uid);
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	
	/**
	 * 发送消息到所有人
	 * @param data
	 */
	public void sendToAllUser(byte[] by)
	{
		for (User u : userMap.values()) {
			u.thread.send(by);
        }
	}
	
	/**
	 * 发送消息到所有人
	 * @param data
	 */
	public void sendToAllUser(byte[] by, String notSendUid)
	{
		User notUser = getUser(notSendUid);
		for (User u : userMap.values()) {
			if(u != notUser) u.thread.send(by);
		}
	}
	
	/**
	 * 发送一个消息给单个用户
	 * @param data
	 * @param uid
	 */
	public void sendToUser(byte[] by, String uid)
	{
		User u = userMap.get(uid);
		if(u != null) u.thread.send(by);
	}
	
	/**
	 * 发送一个消息给单个用户
	 * @param data
	 * @param user
	 */
	static public void sendToUser(byte[] by, User user)
	{
		if(user.getCanSay())
		{
			user.thread.send(by);
		}
	}

}
