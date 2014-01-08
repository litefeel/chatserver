package com.litefeel.chatServer.data;

import java.util.HashMap;

public class UserVars {
	
	private HashMap<String, Object> varsMap = null;
	private HashMap<String, byte[]> varBytesMap = null;
//	private HashMap<String, Byte> typeMap = null;
	
	public HashMap<String, byte[]> getVarsMap() {
		return varBytesMap;
	}
	
	public UserVars() {
		varsMap = new HashMap<String, Object>();
		varBytesMap = new HashMap<String, byte[]>();
//		typeMap = new HashMap<String, Byte>();
	}
	
	public boolean getBoolen(String k) {
		return (Boolean) varsMap.get(k);
	}
	
	public void setBoolen(String k, boolean v) {
		varsMap.put(k, v);
//		typeMap.put(k, DataType.BOOL);
	}
	
	public int getInt(String k) {
		return (Integer) varsMap.get(k);
	}
	
	public void setInt(String k, int v) {
		varsMap.put(k, v);
//		typeMap.put(k, DataType.INT);
	}
	
	public String getString(String k) {
		return (String) varsMap.get(k);
	}
	
	public void setString(String k, String v) {
		varsMap.put(k, v);
//		typeMap.put(k, DataType.STR);
	}
	
	public void setVar(String key, byte[] v, int type) {
		if(type == 1) {
			varBytesMap.remove(key);
			varsMap.remove(key);
		}else {
			varBytesMap.put(key, v);
			varsMap.remove(key);
		}
	}
	
//	public byte[] toBytes() {
//		ByteArray bytes = new ByteArray();
//		for (Map.Entry<String, Byte> m : typeMap.entrySet()) {
//			String k = m.getKey();
//			bytes.writeByte(m.getValue());
//			bytes.writeUTFString(k);
//			switch(m.getValue()) {
//			case DataType.BOOL : bytes.writeBoolean(getBoolen(k)); break;
//			case DataType.INT  : bytes.writeInt(getInt(k)); break;
//			case DataType.STR  : bytes.writeUTFString(getString(k)); break;
//			}
//		}
//		return bytes.array();
//	}
}
