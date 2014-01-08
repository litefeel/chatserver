package com.litefeel.chatServer.utils;

/**
 * 
 * @author lite3
 * 
 */
public class IntUtil {

	public static int toInt(byte[] bytes) {
		int n = (((bytes[0]     & 0xFF) << 24)
				 |((bytes[1] & 0xFF) << 16)
				 |((bytes[2] & 0xFF) << 8)
				 | (bytes[3] & 0xFF));
		return n; 
		
//		int n = ((bytes[0] & 0x7F) << 24) + ((bytes[1] & 0xFF) << 16)
//				+ ((bytes[2] & 0xFF) << 8) + (bytes[3] & 0xFF);
//		// 正数
//		if (0 == (bytes[0] & 0x80))
//			return n;
//
//		// 负数
//		return -(0x7FFFFFFF - n + 1);
	}

	public static byte[] toBytes(int n) {
		byte[] by = { (byte) (n >>> 24), (byte) (n >>> 16), (byte) (n >>> 8), (byte) n };
		return by;
	}
}
