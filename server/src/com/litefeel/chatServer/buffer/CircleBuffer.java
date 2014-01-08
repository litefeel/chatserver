package com.litefeel.chatServer.buffer;

import java.nio.ByteBuffer;

public class CircleBuffer {

	private int len = 0;
	private int pos = 0;
	private int max = 0;
	
	private byte[] by;
	public CircleBuffer(int max)
	{
		this.max = max;
		by = new byte[max];
	}
	
	/**
	 * 获取最大容量
	 * @return
	 */
	public final int getMax() { return max; }
	
	/**
	 * @return 获取可以取得的字节数
	 */
	public final int canGetLen() { return len; }
	
	/**
	 * @return 获取可以存放的字节数
	 */
	public final int canPutLen() { return max - len; }
	
	/**
	 * 获取一个整数,没有考虑负数的情况
	 * @return 没有不够4个字节,返回-1
	 */
	public int getInt()
	{
		if(canGetLen() < 4) return -1;
		int n = (by[pos]&0xFF) << 24 | (by[offsetPos(1)]&0xFF) << 16 | (by[offsetPos(2)]&0xFF) << 8 | (by[offsetPos(3)]&0xFF);
		if(n <= 0)
		{
			System.out.println("getInt异常:n="+n);
			System.out.println(by[pos]);
			System.out.println(by[offsetPos(1)]);
			System.out.println(by[offsetPos(2)]);
			System.out.println(by[offsetPos(3)]);
		}
		pos = offsetPos(4);
		len -= 4;
		return n;
	}
	
	/**
	 * 获取指定数量的字节
	 * @param dest
	 * @param copyLen 获取的数量
	 * @return 获取字节成功（true），还是失败（false）
	 */
	public boolean get(byte[] dest, int copyLen)
	{
		if(len <= 0 || canGetLen() < len) return false;
		
		final int n = max - pos;
		if(n > copyLen)
		{
			System.arraycopy(by, pos, dest, 0, copyLen);
		}else
		{
			System.arraycopy(by, pos, dest, 0, n);
			System.arraycopy(by, 0, dest, n, copyLen - n);
		}
		pos = offsetPos(copyLen);
		len -= copyLen;
		return true;
	}
	
	/**
	 * 放入一个byteBuffer
	 * @param src
	 * @return
	 */
	public boolean put(ByteBuffer src)
	{
		final int srcLen = src.remaining();
		if(0 == srcLen || srcLen > canPutLen()) return false;
		
		final int end = offsetPos(len);
		int n = max - end;
		if(srcLen < n)
		{
			src.get(by, end, srcLen);
		}else
		{
			src.get(by, end, n);
			src.get(by, 0, srcLen - n);
		}
		len += srcLen;
		return true;
	}
	
	private int offsetPos(int i) { return (pos + i) % max; }
}
