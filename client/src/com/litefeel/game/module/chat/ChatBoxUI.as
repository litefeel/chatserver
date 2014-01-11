package com.litefeel.game.module.chat 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author lite3
	 */
	public class ChatBoxUI extends Sprite 
	{
		public var textArea:TextField;
		public var input:TextField;
		
		public function appendText(text:String, newLine:Boolean = true):void
		{
			if (newLine && textArea.length > 0)
			{
				text = "\n" + text;
			}
			textArea.appendText(text);
			stage.invalidate();
		}
		
		public function set autoScroll(value:Boolean):void
		{
			textArea.addEventListener(Event.RENDER, renderHandler);
		}
		
		private function renderHandler(e:Event):void 
		{
			textArea.scrollV = textArea.maxScrollV;
		}
		
		public function ChatBoxUI() 
		{
			init();
			autoScroll = true;
		}
		
		private function init():void 
		{
			textArea = new TextField();
			textArea.multiline = true;
			textArea.wordWrap = true;
			textArea.y = -229;
			textArea.width = 250;
			textArea.height = 200;
			addChild(textArea);
			
			input = new TextField();
			input.type = "input";
			input.border = true;
			input.width = 250;
			input.height = 20;
			input.y = -25;
			addChild(input);
		}
		
	}

}