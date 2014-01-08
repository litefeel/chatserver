package com.litefeel.chatServer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Arrays;

public class PolicyFilePutThread extends Thread {
	
	@Override
	public void run()
	{
		byte[] xml = getCrossDomain();//str.getBytes();
		if(null == xml)
		{
			System.err.println("not crossdomain file!");
			return;
		}
		
		byte[] requestHead = "<policy-file-request/>".getBytes();
		
		ServerSocket serverSocket = null;
		try {
			serverSocket = new ServerSocket(843);
		} catch (IOException e1) {
			e1.printStackTrace();
			System.err.println("843端口被占用了!");
			return;
		}
		
		//新建一个连接
		System.out.println("等待客户端连接...");
		
		while(true)
		{
			try
			{
				Socket socket = serverSocket.accept();
				System.out.println("连接成功......");
				InputStream br = socket.getInputStream();
				OutputStream pw = socket.getOutputStream();
				//接收判断消息
				byte[] by = new byte[22];
				br.read(by,0,22);
				System.out.println("消息头:" + new String(by) + ":");
				if(Arrays.equals(requestHead, by))
				{
					pw.write(xml);
					pw.flush();
					socket.close();
				}
				else
				{
					System.out.println("843端口请求出错!");
				}
			}
			catch (Exception e)
			{
				System.out.println("服务器出现异常！" + e );
			}
		}
	}

	private byte[] getCrossDomain() {
		File file = new File("crossdomain.xml");
		System.out.println("file="+file.getAbsolutePath());
        BufferedReader reader = null;
        String str = "";
        try {
            reader = new BufferedReader(new FileReader(file));
            
            String tempString = null;
            int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
                str += tempString;
            	// 显示行号
                System.out.println("line " + line + ": " + tempString);
                line++;
            }
           
            reader.close();
            return str.getBytes();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
            System.out.println("finally");
        }
        System.out.println("xxxx");
        if(str.equals("")) return null;
        str.trim();
        return str.getBytes();
	} 
}
