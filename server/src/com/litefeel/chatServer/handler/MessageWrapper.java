package com.litefeel.chatServer.handler;

import java.io.IOException;

import com.google.protobuf.CodedInputStream;
import com.litefeel.utils.ArrayUtil;


public final class MessageWrapper {
	
	public byte header;
	public byte action;
	public byte[] msg;
	
//	public MessageWrapper(byte header, byte action, byte[] msg)
//	{
//		this.header = header;
//		this.action = action;
//		this.msg = msg;
//	}
	
//	public MessageWrapper(byte header, byte action, String msg) {
//		this.header = header;
//		this.action = action;
//		try {
//			this.msg = msg.getBytes("UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	public MessageWrapper(byte[] data)
	{
		System.out.println("[receive] " + ArrayUtil.toHexString(data));
		CodedInputStream input = CodedInputStream.newInstance(data);
		try {
			input.readTag();
			header = (byte)input.readInt32();
			input.readTag();
			action = (byte)input.readInt32();
			msg = data;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//System.arraycopy(data, 2, msg, 0, msg.length);
	}
	
//	public String getMsg()
//	{
//		try {
//			return new String(msg, "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return null;
//		}
//	}
	
//	public static final byte[] wrapper(byte header, byte action, byte[] msg)
//	{
//		byte[] by = new byte[msg.length+2];
//		by[0] = header;
//		by[1] = action;
//		System.arraycopy(msg, 0, by, 2, msg.length);
//		return by;
//	}
	
//	public static final byte[] wrapper(byte header, byte action, String msg)
//	{
//		byte[] src = null;
//		try {
//			src = msg.getBytes("UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		byte[] by = new byte[src.length+2];
//		by[0] = header;
//		by[1] = action;
//		System.arraycopy(src, 0, by, 2, src.length);
//		return by;
//	}
}
