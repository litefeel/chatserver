package com.litefeel.chatServer.data
{
	public class Position
	{
		public var time:Number = 0;
		public var x:Number = 0;
		public var y:Number = 0;
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public function Position(x:Number = 0, y:Number = 0, vx:Number = 0, vy:Number = 0, time:Number = 0)
		{
			update(x, y, vx, vy, time);
		}
		
		public function update(x:Number, y:Number, vx:Number, vy:Number, time:Number):void
		{
			this.time = time;
			this.x = x;
			this.y = y;
			this.vx = vx;
			this.vy = vy;
		}
		
		public function toString():String
		{
			return "[ Posiont x=" + x + " , y=" + y + " , vx=" + vx + " , vy=" + vy + " , time=" + time + " ]";
		}
	}
}