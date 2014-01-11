package com.litefeel.chatServer.serialization 
{
	/**
	 * ...
	 * @author lite3
	 */
	public class Obj 
	{
		private var typeMap:Object = { };
		private var valueMap:Object = { };
		
		public function Obj() 
		{
			
		}
		
		public function setBool(key:String, bool:Boolean):void
		{
			typeMap[key] = bool;
			valueMap[key] = bool;
		}
		
		public function getBool(key:String):Boolean
		{
			return valueMap[key];
		}
		
	}

}