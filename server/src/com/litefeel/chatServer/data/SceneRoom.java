package com.litefeel.chatServer.data;

import java.util.HashMap;

public class SceneRoom extends Room {

	public HashMap<String, Position> posMap;
	
	public SceneRoom()
	{
		super();
		posMap = new HashMap<String, Position>();
	}
	
	public Position getPos(String uid) {
		return posMap.get(uid);
	}

	public boolean updatePos(String uid, float x, float y, float vx, float vy, float time) {
		Position p = posMap.get(uid);
		if(null == p)
		{
			p = new Position(x, y, vx, vy, time);
			posMap.put(uid, p);
			return true;
		}else if(p.x != x || p.y != y || p.vx != vx || p.vy != vy || p.time != time)
		{
			p.x = x;
			p.y = y;
			p.vx = vx;
			p.vy = vy;
			return true;
		}
		
		return false;
	}
	
	@Override
	public User removeUser(User user) {
		posMap.remove(user.uid);
		return super.removeUser(user);
	}

}
