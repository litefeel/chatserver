package com.litefeel.chatServer.data
{
	import com.litefeel.chatServer.ChatServer;
	import com.litefeel.chatServer.ns.CS;
	import flash.utils.ByteArray;
	

	
	/**
	 * ...
	 * @author lite3
	 */
	public class User
	{
		
		public var uid:String;
		public var name:String;
		
		public var vars:UserVars;
		
		private var chatServer:ChatServer;
		
		public function User(uid:String, name:String) 
		{
			this.uid = uid;
			this.name = name;
			vars = new UserVars();
		}
		
		public function get isMy():Boolean
		{
			return chatServer && chatServer.myId == uid;
		} 
		
		public function setBoolen(k:String, v:Boolean):void {
			if(chatServer.myId != uid) return;
			vars.setBoolen(k, v);
		}
		
		public function setInt(k:String, v:int):void {
			if(chatServer.myId != uid) return;
			vars.setInt(k, v);
		}
		
		public function setString(k:String, v:String):void {
			if(chatServer.myId != uid) return;
			vars.setString(k, v);
		}
		
		public function setBytes(k:String, v:ByteArray):void
		{
			if(chatServer.myId != uid) return;
			vars.setBytes(k, v);
		}
		
		public function delVar(k:String):void
		{
			if(chatServer.myId != uid) return;
			vars.delVar(k);
		}
		
		CS function setChatServer(chatServer:ChatServer):void
		{
			this.chatServer = chatServer;
		}
	}
}