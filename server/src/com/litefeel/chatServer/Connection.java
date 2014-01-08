package com.litefeel.chatServer;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.SelectableChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.SocketChannel;

import com.litefeel.chatServer.buffer.CircleBuffer;
import com.litefeel.chatServer.data.User;
import com.litefeel.chatServer.handler.MessageWrapper;
import com.litefeel.chatServer.handler.SystemHandler;

public class Connection {

	private SelectionKey key;
	
	// 最后心跳包的时间, 毫秒为单位
	public long lastTime = 0;
	private User		user;
	private ByteBuffer outBuffer;
	private ByteBuffer inBuffer;
	private CircleBuffer buffer;
	private int packageLen = -1;
	
	public Connection(SelectionKey key)
	{
		this.key = key;
		outBuffer = ByteBuffer.allocate(1024);
		inBuffer  = ByteBuffer.allocate(1024);
		buffer = new CircleBuffer(1024);
	}
	
	public User getUser() { return user; }
	
	/**
	 * 销毁
	 */
	public void destroy()
	{
		if(this.user != null)
		{
			SystemHandler.userDisconnect(user);
		}
		
		try
		{
			SelectableChannel c = key.channel();
			if(c != null) c.close();
			System.out.println("destroy()");
			key.cancel();
			key = null;
		}
		catch (Exception er)
		{
			System.out.println("关闭资源发生异常");
		}
		user = null;
		
		System.out.println("当前线程结束! " + this.toString());
	}
	
	/**
	 * 设置用户
	 * @param u
	 */
	public void setUser(User u)
	{
		user = u;
	}
	
	synchronized
	public boolean send(MessageWrapper wrapper)
	{
		SocketChannel sc = (SocketChannel)key.channel();
		outBuffer.clear();
		outBuffer.putInt(wrapper.msg.length + 2);
		outBuffer.put(wrapper.header);
		outBuffer.put(wrapper.action);
		outBuffer.put(wrapper.msg);
		outBuffer.flip();
		try {
			sc.write(outBuffer);
			return true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	synchronized
	public boolean send(byte[] by)
	{
		showBytes(by);
		SocketChannel sc = (SocketChannel)key.channel();
		outBuffer.clear();
		outBuffer.putInt(by.length);
		outBuffer.put(by);
		outBuffer.flip();
		try {
			sc.write(outBuffer);
			return true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	
	private void showBytes(byte[] bytes)
	{
		StringBuffer s = new StringBuffer("[len ");
		int len = bytes.length;
		s.append(len).append(']').append(' ');
		for(int i = 0; i < len; i++)
		{
			if(bytes[i] <= 16) s.append('0');
			s.append(Integer.toHexString(bytes[i] & 0xFF).toUpperCase());
			s.append(' ');
		}
		System.out.println(s);
	}
	
	public void readMsg()
	{
		SocketChannel sc = (SocketChannel)key.channel();
		inBuffer.clear();
		try {
			sc.read(inBuffer);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			System.out.println("用户离线, uid="+(user != null ? user.uid : ""));
			this.destroy();
			return;
		}
		inBuffer.flip();
		if(!inBuffer.hasRemaining())
		{
			this.destroy();
			return;
		}
		if(!buffer.put(inBuffer))
		{
			System.err.println("数据读取出错,buffer空间不足");
			return;
		}
		while(true)
		{
			if(-1 == packageLen) packageLen = buffer.getInt();
			if(-1 == packageLen) break;
			
			if(buffer.canGetLen() < packageLen) break;
			
			byte[] by = new byte[packageLen];
//			System.out.println("xxxxxxxxxxxxx"+buffer.canGetLen()+"_"+buffer.canPutLen()+"_"+buffer.getPos()+"_"+buffer.getEnd()+"_"+packageLen);
			buffer.get(by, packageLen);
			
			packageLen = -1;
			SystemHandler.handler(this, by);
		}
	}
}
