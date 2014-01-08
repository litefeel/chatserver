package com.litefeel.chatServer.data;

import java.util.HashMap;
import java.util.Map;

import com.litefeel.chatServer.handler.ByteArray;

public class Obj {
	
	private HashMap<String, Object> varsMap = null;
	private HashMap<String, Byte> typeMap = null;
	
	public Obj() {
		varsMap = new HashMap<String, Object>();
		typeMap = new HashMap<String, Byte>();
	}
	
	public boolean getBoolen(String k) {
		return (Boolean) varsMap.get(k);
	}
	
	public void setBoolen(String k, boolean v) {
		varsMap.put(k, v);
		typeMap.put(k, DataType.BOOL);
	}
	
	public int getInt(String k) {
		return (Integer) varsMap.get(k);
	}
	
	public void setInt(String k, int v) {
		varsMap.put(k, v);
		typeMap.put(k, DataType.INT);
	}
	
	public String getString(String k) {
		return (String) varsMap.get(k);
	}
	
	public void setString(String k, String v) {
		varsMap.put(k, v);
		typeMap.put(k, DataType.STR);
	}
	
	public void setVar(String k, Object v, int type) {
		switch(type) {
		case DataType.DEL  : typeMap.remove(k); varsMap.remove(k); break;
		case DataType.BOOL : setBoolen(k, (Boolean) v); break;
		case DataType.INT  : setInt(k, (Integer) v); break;
		case DataType.STR  : setString(k, (String) v); break;
		}
	}
	
	public byte[] toBytes() {
		ByteArray bytes = new ByteArray();
		for (Map.Entry<String, Byte> m : typeMap.entrySet()) {
			String k = m.getKey();
			bytes.writeByte(m.getValue());
			bytes.writeUTFString(k);
			switch(m.getValue()) {
			case DataType.BOOL : bytes.writeBoolean(getBoolen(k)); break;
			case DataType.INT  : bytes.writeInt(getInt(k)); break;
			case DataType.STR  : bytes.writeUTFString(getString(k)); break;
			}
		}
		return bytes.array();
	}
}
