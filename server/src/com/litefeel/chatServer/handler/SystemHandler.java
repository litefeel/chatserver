package com.litefeel.chatServer.handler;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.protobuf.ByteString;
import com.litefeel.chatServer.Connection;
import com.litefeel.chatServer.ChatServer;
import com.litefeel.chatServer.data.Position;
import com.litefeel.chatServer.data.Room;
import com.litefeel.chatServer.data.SceneRoom;
import com.litefeel.chatServer.data.User;
import com.litefeel.chatServer.data.Zone;
import com.litefeel.chatServer.requests.Request.HeartbeatRequest;
import com.litefeel.chatServer.requests.Request.JoinRoomRequest;
import com.litefeel.chatServer.requests.Request.LeaveRoomRequest;
import com.litefeel.chatServer.requests.Request.LoginRequest;
import com.litefeel.chatServer.requests.Request.LogoutRequest;
import com.litefeel.chatServer.requests.Request.PrivateMessageRequest;
import com.litefeel.chatServer.requests.Request.PublicMessageRequest;
import com.litefeel.chatServer.requests.Request.UpdatePositionRequest;
import com.litefeel.chatServer.requests.Request.UpdateUserVarRequest;
import com.litefeel.chatServer.requests.Request.UserVar;
import com.litefeel.chatServer.requests.Request.ZoneMessageRequest;
import com.litefeel.chatServer.responders.Responder.JoinRoomResponder;
import com.litefeel.chatServer.responders.Responder.LeaveRoomResponder;
import com.litefeel.chatServer.responders.Responder.LoginKOResponder;
import com.litefeel.chatServer.responders.Responder.LoginOKResponder;
import com.litefeel.chatServer.responders.Responder.PrivateMessageResponder;
import com.litefeel.chatServer.responders.Responder.PublicMessageResponder;
import com.litefeel.chatServer.responders.Responder.RoomListResponder;
import com.litefeel.chatServer.responders.Responder.UpdatePosResponder;
import com.litefeel.chatServer.responders.Responder.UpdateUserVarResponder;
import com.litefeel.chatServer.responders.Responder.UserJoinResponder;
import com.litefeel.chatServer.responders.Responder.UserLeaveResponder;
import com.litefeel.chatServer.responders.Responder.UserVo;
import com.litefeel.chatServer.responders.Responder.ZoneMessageResponder;


public class SystemHandler
{
	public static Zone zone = null;
	
	interface IHandler {
		void handler(Connection c, byte[] b);
	};
	
	public static void handler(Connection thread, byte[] data)
	{
		
		//SystemHandler.leaveRoomHandler, request)logoutHandler
		try
		{
			MessageWrapper warper = new MessageWrapper(data);
			
			User user = thread.getUser();
			// 未登陆过的
			if(null == user)
			{
				if(ClientActionType.LOGIN == warper.action)
				{
					loginHandler(thread, LoginRequest.parseFrom(data));
				}
			}
			// 登陆过的
			else
			{
				
				switch(warper.action)
				{
					case ClientActionType.LOGOUT :
						logoutHandler(thread, LogoutRequest.parseFrom(data));
						break;
						
					case ClientActionType.PRI_MSG :
						privateMessageHandler(thread, PrivateMessageRequest.parseFrom(data));
						break;
						
					case ClientActionType.PUB_MSG :
						publicMessageHandler(thread, PublicMessageRequest.parseFrom(data));
						break;
						
					case ClientActionType.ZONE_MSG :
						zoneMessageHandler(thread, ZoneMessageRequest.parseFrom(data));
						break;
						
					case ClientActionType.GET_ROOM_LIST :
						getRoomListHandler(thread);
						break;
						
					case ClientActionType.JOIN_ROOM :
						joinRoomHandler(thread, JoinRoomRequest.parseFrom(data));
						break;
						
					case ClientActionType.LEAVE_ROOM :
						leaveRoomHandler(thread, LeaveRoomRequest.parseFrom(data));
						break;
						
					case ClientActionType.UPDATE_POS :
						updatePositionHandler(thread, UpdatePositionRequest.parseFrom(data));
						break;
						
					case ClientActionType.UPDATE_USER_VAR :
						updateUserVarHandler(thread, UpdateUserVarRequest.parseFrom(data));
						break;
						
					case ClientActionType.HEAD_BEAT :
						headBeatHandler(thread, HeartbeatRequest.parseFrom(data));
						break;
						
					default :
						System.out.println("未知的action:"+warper.action);
						break;
				}
			}
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static void headBeatHandler(Connection thread, HeartbeatRequest responder) {
		thread.lastTime = System.currentTimeMillis();
	}

	private static void updateUserVarHandler(Connection thread, UpdateUserVarRequest request) {
		User u = thread.getUser();
		List<UserVar> vars = request.getVarListList();
		int count = request.getVarListCount();
		for(int i = 0; i < count; i++)
		{
			UserVar var = vars.get(i);
			u.getVars().setVar(var.getKey(), var.getValue().toByteArray(), var.getOp());
		}
		
		if(0 == u.getRoomCount()) return;
		
		
		UpdateUserVarResponder.Builder builder = UpdateUserVarResponder.newBuilder();
		builder.setHead(builder.getType()).setType(builder.getType())
			.setUserId(u.uid).addAllVarList(vars);
				
		
		int[] list = u.getRoomList();
		for(int i = list.length - 1; i >= 0; i--) {
			Room r = zone.getRoom(list[i]);
			if(null == r || 1 == r.getUserCount()) continue;
			
			r.sendToAllUser(builder.setRoomId(r.getId()).build().toByteArray(), u.uid);
		}
	}

	private static void leaveRoomHandler(Connection thread, LeaveRoomRequest request) {
		int rid = request.getRoomId();
		User u = thread.getUser();
		Room r = zone.removeUserFromRoom(u, rid);
		if(null == r) return;
		
		if(r.getUserCount() > 0) {
			UserLeaveResponder.Builder userLeave = UserLeaveResponder.newBuilder();
			userLeave.setHead(userLeave.getHead()).setType(userLeave.getType())
				.setRoomId(rid).setUserId(u.uid);
			r.sendToAllUser(userLeave.build().toByteArray());
		}
		
		LeaveRoomResponder.Builder leaveRoom = LeaveRoomResponder.newBuilder();
		leaveRoom.setHead(leaveRoom.getHead()).setType(leaveRoom.getType())
			.setRoomId(rid);
		thread.send(leaveRoom.build().toByteArray());
	}

	private static void updatePositionHandler(Connection thread, UpdatePositionRequest request) {
		User u = thread.getUser();
		int rid = request.getRoomId();
		if(rid <= 0) rid = u.getLassRoomId();
		Room r = zone.getRoom(rid);
		if(!(r instanceof SceneRoom)) return;
		SceneRoom sr = (SceneRoom) r;
		
		// {x, y, vx, vy, time}
		Float[] pos = new Float[5];
		request.getPosListList().toArray(pos);
		if(sr.updatePos(u.uid, pos[0], pos[1], pos[2], pos[3], pos[4]))
		{
			UpdatePosResponder.Builder updatePos = UpdatePosResponder.newBuilder();
			updatePos.setHead(updatePos.getHead()).setType(updatePos.getType())
				.setRoomId(r.getId()).setUserId(u.uid)
				.addPosList(pos[0]).addPosList(pos[1]).addPosList(pos[2])
				.addPosList(pos[3]).addPosList(pos[4]);
			sr.sendToAllUser(updatePos.build().toByteArray(), u.uid);
		}
	}

	private static void joinRoomHandler(Connection thread, JoinRoomRequest request) {
		int rid = request.getRoomId();
		User u = thread.getUser();
		if(null == u) return;
		
		if(!zone.joinRoom(u, rid)) return;
		
		Room r = zone.getRoom(rid);
		SceneRoom sr = r instanceof SceneRoom ? (SceneRoom)r : null;
		HashMap<String, User> map = r.getUserMap();
		
		if(sr != null) sr.updatePos(u.uid, 0, 0, 0, 0, 0);
		
		UserVo.Builder myUserBuilder = getUserVoBuilder(u, sr);
		
		byte[] userJoinBytes = null;
		if(r.getUserCount() > 1) {
			UserJoinResponder.Builder userJoin = UserJoinResponder.newBuilder();
			userJoin.setHead(userJoin.getHead()).setType(userJoin.getType())
				.setRoomId(rid).setUser(myUserBuilder);
			userJoinBytes = userJoin.build().toByteArray();
		}
		
		JoinRoomResponder.Builder joinRoomBuilder = JoinRoomResponder.newBuilder()
				.setRoomId(rid).addUserList(myUserBuilder);
		joinRoomBuilder.setHead(joinRoomBuilder.getHead()).setType(joinRoomBuilder.getType());
		
		// 对房间内的人通知
		for (User tmp : map.values()) {
			if(tmp == u) continue;
			
			tmp.thread.send(userJoinBytes);
			joinRoomBuilder.addUserList(getUserVoBuilder(tmp, sr));
        }
		
		// 对自己说
		thread.send(joinRoomBuilder.build().toByteArray());
	}
	
	static private UserVo.Builder getUserVoBuilder(User u, SceneRoom r)
	{
		UserVo.Builder userVoBuilder = UserVo.newBuilder()
				.setUid(u.uid).setName(u.name);
	
		for (Map.Entry<String, byte[]> entry : u.getVars().getVarsMap().entrySet()) {
			userVoBuilder.addVarList(UserVar.newBuilder()
					.setKey(entry.getKey())
					.setValue(ByteString.copyFrom(entry.getValue())));	
		}
		if(r != null) {
			Position tempPos = r.getPos(u.uid);
			userVoBuilder.addPosList(tempPos.x).addPosList(tempPos.y)
			.addPosList(tempPos.vx).addPosList(tempPos.vy)
			.addPosList(tempPos.time);
		}
		return userVoBuilder;
	}

	static private void loginHandler(Connection thread, LoginRequest request)
	{
		// userName, password, nickName
		String[] info = ChatServer.dbManager.getUserInfo(request.getUserId());
		
		// 验证密码正确
		if(info != null && request.getPw().equals(info[1]))
		{
			String name = info[2];
			User u = new User(request.getUserId(), name, thread);
			u.getVars().setInt("color", (int) (Math.random()*0xFFFFFF));
			thread.setUser(u);
			zone.login(u);
			System.out.println("新用户登陆-uid:"+u.uid+"\n当前用户数:"+zone.getOnlineUserCount());
			LoginOKResponder.Builder loginOk = LoginOKResponder.newBuilder();
			loginOk.setHead(loginOk.getHead()).setType(loginOk.getType())
				.setId(u.uid).setName(name);
			thread.send(loginOk.build().toByteArray());
		}
		// 密码错误
		else
		{
			LoginKOResponder.Builder loginKO = LoginKOResponder.newBuilder();
			loginKO.setHead(loginKO.getHead()).setType(loginKO.getType())
				.setError("用户名或密码错误!");
			thread.send(loginKO.build().toByteArray());
		}
		
	}
	
	static private void zoneMessageHandler(Connection thread, ZoneMessageRequest request)
	{
//		String message = filter(request.msg);
		User u = thread.getUser();
		if(null == u) return;
		
		ZoneMessageResponder.Builder zoneMsg = ZoneMessageResponder.newBuilder();
		zoneMsg.setHead(zoneMsg.getHead()).setType(zoneMsg.getType())
			.setUserId(u.uid).setUserName(u.name).setMsg(request.getMsg());
		zone.sendAll(zoneMsg.build().toByteArray());
	}
	
	static private void publicMessageHandler(Connection thread, PublicMessageRequest request)
	{
		User u = thread.getUser();
		int rid = request.getRoomId() > 0 ? request.getRoomId() : u.getLassRoomId();
		Room r = zone.getRoom(rid);
		if(null == r) return;
		String msg = filter(request.getMsg());
		
		PublicMessageResponder.Builder pubMsg = PublicMessageResponder.newBuilder();
		pubMsg.setHead(pubMsg.getHead()).setType(pubMsg.getType())
			.setRoomId(rid).setUserId(u.uid).setMsg(msg);
		r.sendToAllUser(pubMsg.build().toByteArray());
	}
	
	static private void privateMessageHandler(Connection thread, PrivateMessageRequest request)
	{
		User toUser = zone.getUser(request.getToId());
		if(null == toUser) return;
		
		String message = filter(request.getMsg());
		
		User my = thread.getUser();
		PrivateMessageResponder.Builder priMsg = PrivateMessageResponder.newBuilder();
		priMsg.setHead(priMsg.getHead()).setType(priMsg.getType())
			.setUserId(my.uid).setUserName(my.name).setMsg(message);
		toUser.thread.send(priMsg.build().toByteArray());
	}

	static private void getRoomListHandler(Connection thread)
	{
		RoomListResponder.Builder builder = RoomListResponder.newBuilder();
		builder.setHead(builder.getHead()).setType(builder.getType());
		List<Room> list = zone.getRoomList();
		int len = list.size();
		for(int i = 0; i < len; i++) {
			builder.addIdList(list.get(i).getId());
			builder.addNameList(list.get(i).getName());
		}
		thread.send(builder.build().toByteArray());
	}
	
	static private void logoutHandler(Connection thread, LogoutRequest request)
	{
		
	}
	
	/**
	 * 过滤字符串
	 * @param message
	 * @return
	 */
	private static String filter(String message)
	{
//		Pattern pattern = Pattern.compile("<.+?>", Pattern.DOTALL); 
//		Matcher matcher = pattern.matcher(message); 
//		String string = matcher.replaceAll(""); 
		return message;
	}

	public static void userDisconnect(User u) {
		if(u.getLassRoomId() != -1)
		{
			UserLeaveResponder.Builder builder = UserLeaveResponder.newBuilder();
			builder.setHead(builder.getHead()).setType(builder.getType()).setUserId(u.uid);
			int[] arr = u.getRoomList();
			for(int i = arr.length - 1; i >= 0; i--)
			{
				Room r = zone.getRoom(arr[i]);
				r.removeUser(u);
				if(0 == r.getUserCount()) continue;
				
				r.sendToAllUser(builder.setRoomId(r.getId()).build().toByteArray());
			}
		}
		
		u.removeAllRoom();
		zone.logout(u.uid);
	}
}
