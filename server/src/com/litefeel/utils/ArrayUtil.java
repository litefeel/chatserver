package com.litefeel.utils;

public final class ArrayUtil {

	public static String toHexString(byte[] bytes) {
		StringBuffer s = new StringBuffer("[len ");
		int len = bytes.length;
		s.append(len).append(']').append(' ');
		for(int i = 0; i < len; i++)
		{
			if(bytes[i] <= 16) s.append('0');
			s.append(Integer.toHexString(bytes[i] & 0xFF).toUpperCase());
			s.append(' ');
		}
		return s.toString();
//		System.out.println(s);
	}
}
