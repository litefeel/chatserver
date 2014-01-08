package com.litefeel.chatServer;

import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

import com.litefeel.chatServer.data.User;
import com.litefeel.chatServer.data.Zone;
import com.litefeel.chatServer.responders.Responder.HeartbeatResponder;

public class HeartBeatThread {

	public long checkPeriod = 1000;
	public long timeoutTime = 4000;
	
	private Zone zone;
	private Timer timer;
	public HeartBeatThread(Zone zone) {
		this.zone = zone;
		timer = new Timer();
		timer.schedule(new HeartBeatTask(zone), checkPeriod, checkPeriod);
		timer.schedule(new CheckHeartBeatTask(zone, timeoutTime), checkPeriod, checkPeriod);
	}
	
}

class HeartBeatTask extends TimerTask {

	private byte[] heartBeatBytes;
	private Zone zone;
	public HeartBeatTask(Zone zone) {
		this.zone = zone;
		heartBeatBytes = HeartbeatResponder.newBuilder().build().toByteArray();
	}
	@Override
	public void run() {
		System.out.println("--------------HeartBeatTask----------------");
		User[] list = zone.getOnlineUserList();
		int len = list.length;
		
		for(int i = 0; i < len; i++)
		{
			list[i].thread.send(heartBeatBytes);
		}
	}
	
}

class CheckHeartBeatTask extends TimerTask {

	ArrayList<String> offlineList = null;
	private Zone zone;
	private long timeoutTime;
	public CheckHeartBeatTask(Zone zone, long timeoutTime) {
		this.zone = zone;
		this.timeoutTime = timeoutTime;
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		
		User[] list = zone.getOnlineUserList();
		int len = list.length;
		long curTime = System.currentTimeMillis();
		System.out.println("---------------检测断线---"+len+"----------");
		if(null == offlineList) {
			offlineList = new ArrayList<String>();
		}
		for(int i = 0; i < len; i++)
		{
			long lastTime = list[i].thread.lastTime;
			if(lastTime > 0 && curTime - lastTime > timeoutTime) {
				System.err.println("丢失连接:"+list[i].uid);
				list[i].thread.destroy();
			}
		}
		
	}
	
}
