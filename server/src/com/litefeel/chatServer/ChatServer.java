package com.litefeel.chatServer;

import java.net.InetSocketAddress;
import java.net.Socket;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.HashMap;
import java.util.Set;

import com.litefeel.chatServer.data.SceneRoom;
import com.litefeel.chatServer.data.User;
import com.litefeel.chatServer.data.Zone;
import com.litefeel.chatServer.handler.SystemHandler;
import com.litefeel.chatServer.manager.DbManager;


public class ChatServer
{
	static public HashMap<String, User> userMap;
//	static public Zone zone;
	static public DbManager dbManager;
	
	
	public ChatServer() throws Exception
	{
		Zone zone = new Zone();
		userMap = new HashMap<String, User>();
		dbManager = new DbManager();
		dbManager.initManager();
		
		initRoomList(zone);
		
		SystemHandler.zone = zone;
		
		//new HeartBeatThread(zone);
	}
	
	private void initRoomList(Zone zone) {
		for(int i = 1; i <= 10; i++){
			SceneRoom r = new SceneRoom();
			r.setId(i);
			r.setName("room"+i);
			zone.addRoom(r);
		}
	}

	public void start() throws Exception
	{
		new PolicyFilePutThread().start();
		
		System.out.println("服务器启动成功!");
		int clientId = 0;
		
        ServerSocketChannel ss = ServerSocketChannel.open();
        ss.socket().bind(new InetSocketAddress(5000));
        ss.configureBlocking(false);
        Selector se = Selector.open();
        ss.register(se, SelectionKey.OP_ACCEPT);
        while (se.select() > 0) {
            Set<SelectionKey> set = se.selectedKeys();
            for (SelectionKey key : set) {
                if (key.isAcceptable()) {
                    SocketChannel sc = ss.accept();
                    Socket socket = sc.socket();
                    System.err.println("有新的连接:add="+socket.getInetAddress()+"\tport="+socket.getPort());
                    sc.configureBlocking(false);
                    SelectionKey another = sc.register(se, SelectionKey.OP_READ);
                    another.attach(new Connection(another));
                    clientId++;
                }else if (key.isReadable()) {
//                    SocketChannel sc = (SocketChannel) key.channel();
                   ((Connection)key.attachment()).readMsg();
                }
            }
            set.clear();
        }
	}
	
	static public void main(String[] r)
	{
		try
		{
			new ChatServer().start();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("socket异常:" + e);
		}
	}
}
