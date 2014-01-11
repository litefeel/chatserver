package com.litefeel.chatServer.data
{
	public class SceneRoom extends Room
	{
		
		private var posMap:Object = {};
		
		public function SceneRoom(id:int, name:String)
		{
			super(id, name);
		}
		
		public function getUserPos(uid:String):Position
		{
			return posMap[uid] as Position;
		}
		
		public function updateUserPos(uid:String, x:Number, y:Number, vx:Number, vy:Number, time:Number):void
		{
			var pos:Position = getUserPos(uid);
			if(!pos) return ;
			pos.x = x;
			pos.y = y;
			pos.vx = vx;
			pos.vy = vy;
			pos.time = time;
		}
		
		override public function addUser(u:User):void
		{
			super.addUser(u);
			posMap[u.uid] = new Position();
		}
		
		override public function removeUser(uid:String):User
		{
			var u:User = super.removeUser(uid);
			if(u) delete posMap[u.uid];
			return u;
		}
	}
}