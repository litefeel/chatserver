package com.litefeel.chatServer.data
{
	public class Room
	{
		
		public var id:int;
		public var name:String;
		
		private var _userList:Vector.<User>;
		
		public function get userList():Vector.<User> { return _userList;}
		
		public function Room(id:int, name:String)
		{
			this.id = id;
			this.name = name;
			_userList = new Vector.<User>();
		}
		
		public function getUser(uid:String):User
		{
			for(var i:int = userList.length - 1; i >= 0; i--)
			{
				if(userList[i].uid == uid)
				{
					return userList[i];
				}
			}
			return null;
		}
		
		public function addUser(u:User):void
		{
			userList.push(u);
		}
		
		public function removeUser(uid:String):User
		{
			for(var i:int = userList.length - 1; i >= 0; i--)
			{
				if(userList[i].uid == uid)
				{
					return userList.splice(i, 1)[0];
				}
			}
			return null;
		}
	}
}