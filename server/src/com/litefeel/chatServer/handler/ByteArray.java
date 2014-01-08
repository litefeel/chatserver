package com.litefeel.chatServer.handler;

import java.io.UnsupportedEncodingException;

public class ByteArray {

	private byte[] bytes;
	public int pos = 0;

	public ByteArray(byte[] bytes) {
		this.bytes = bytes;
	}

	public ByteArray(int len) {
		bytes = new byte[len];
	}

	public ByteArray() {
		bytes = new byte[128];
	}
	
	public boolean readBoolean() {
		return 0 == bytes[pos++];
	}

	public void writeBoolean(boolean b) {
		ensureCapacity(pos + 1);
		bytes[pos++] = (byte) (b ? 1 : 0);
	}

	public byte readByte() {
		return bytes[pos++];
	}

	public void writeByte(byte b) {
		ensureCapacity(pos + 1);
		bytes[pos++] = b;
	}

	public short readShort() {
		short n = (short) (((((short)bytes[pos] & 0xFF))<<8)
						   |((short)bytes[pos + 1] & 0xFF));
		pos += 2;
		return n;
//		int n = ((bytes[pos] & 0x7F) << 8) + (bytes[pos + 1] & 0xFF);
//		// 正数
//		if (0 == (bytes[pos] & 0x80))
//			return (short) n;
//
//		// 负数
//		return (short) (-(0x7FFF - n + 1));
	}

	public void writeShort(short n) {
		ensureCapacity(pos + 2);
		bytes[pos] 	   = (byte) (n >>> 8);
		bytes[pos + 1] = (byte) n;
		pos += 2;
	}

	public int readInt() {
		int n = (((bytes[pos]     & 0xFF) << 24)
				 |((bytes[pos + 1] & 0xFF) << 16)
				 |((bytes[pos + 2] & 0xFF) << 8)
				 | (bytes[pos + 3] & 0xFF));
		pos += 4;
		return n; 
		
//		int n = ((bytes[pos] & 0x7F) << 24) + ((bytes[pos + 1] & 0xFF) << 16)
//				+ ((bytes[pos + 2] & 0xFF) << 8) + (bytes[pos + 3] & 0xFF);
//		// 正数
//		if (0 == (bytes[pos] & 0x80))
//			return n;
//
//		// 负数
//		return -(0x7FFFFFFF - n + 1);
	}
	
	public void writeInt(int n) {
		ensureCapacity(pos + 4);
		bytes[pos]	   = (byte) (n >>> 24);
		bytes[pos + 1] = (byte) (n >>> 16);
		bytes[pos + 2] = (byte) (n >>> 8);
		bytes[pos + 3] = (byte) n;
		pos += 4;
	}

	public float readFloat() {
		return Float.intBitsToFloat(readInt());
	}
	
	public void writeFloat(float f) {
		writeInt(Float.floatToIntBits(f));
	}
	
	public byte[] readBytes(int len) {
		byte[] by = new byte[len];
		System.arraycopy(bytes, pos, by, 0, len);
		pos += len;
		return by;
	}
	
	public void writeBytes(byte[] by) {
		ensureCapacity(pos + by.length);
		System.arraycopy(by, 0, bytes, pos, by.length);
		pos += by.length;
	}

	public void writeUTFString(String s) {
		byte[] by = null;
		try {
			by = s.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ensureCapacity(pos + 2 + by.length);

		writeShort((short) by.length);
		System.arraycopy(by, 0, bytes, pos, by.length);
		pos += by.length;
	}

	public String readUTFString() throws UnsupportedEncodingException {
		short len = readShort();
		String s = new String(bytes, pos, len, "UTF-8");
		pos += len;
		return s;
	}
	
	public byte[] array() {
		byte[] by = new byte[pos];
		System.arraycopy(bytes, 0, by, 0, pos);
		return by;
	}
	
	public void ensureCapacity(int minCapacity) {
		int len = bytes.length;
		if(len >= minCapacity) return;
		
		len = ((minCapacity / len) + 1) * len;
		if(len < minCapacity) len = Integer.MAX_VALUE;
		
		byte[] newBytes = new byte[len];
		System.arraycopy(bytes, 0, newBytes, 0, bytes.length);
		bytes = newBytes;
	}
}
