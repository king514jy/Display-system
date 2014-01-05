package view.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class Menu extends Sprite
	{
		private var autoMc:MovieClip;
		private var ipMc:MovieClip
		private var sendMc:MovieClip;
		private var shoutdownMc:MovieClip;
		private var aboutMc:MovieClip;
		private var nowMenu:MovieClip;
		public function Menu()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			autoMc = this.getChildByName("auto_mc") as MovieClip;
			autoMc.addEventListener(MouseEvent.CLICK,clickHandle);
			ipMc = this.getChildByName("ip_mc") as MovieClip;
			ipMc.addEventListener(MouseEvent.CLICK,clickHandle);
			sendMc = this.getChildByName("send_mc") as MovieClip;
			sendMc.addEventListener(MouseEvent.CLICK,clickHandle);
			shoutdownMc = this.getChildByName("shoutdown_mc") as MovieClip;
			shoutdownMc.addEventListener(MouseEvent.CLICK,clickHandle);
			aboutMc = this.getChildByName("about_mc") as MovieClip;
			aboutMc.addEventListener(MouseEvent.CLICK,clickHandle);
		}
		private function rollOver(e:TouchEvent):void
		{
			var mc:MovieClip = e.target as MovieClip;
			mc.gotoAndStop(2);
		}
		private function rollOut(e:TouchEvent):void
		{
			var mc:MovieClip = e.target as MovieClip;
			mc.gotoAndStop(1);
		}
		private function clickHandle(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			if(nowMenu!=mc)
			{
				if(nowMenu)
					back();
				mc.gotoAndStop(2);
				nowMenu = mc;
				switch(mc)
				{
					case autoMc:
						autoHandle();
						break;
					case ipMc:
						ipHandle();
						break;
					case sendMc:
						sendHandle();
						break;
					case shoutdownMc:
						shoutdownHandle();
						break;
					case aboutMc:
						aboutHandle();
						break;
				}
			}
		}
		public function back():void
		{
			nowMenu.gotoAndStop(1);
			nowMenu =null;
		}
		private function autoHandle():void
		{
			
		}
		private function ipHandle():void
		{
			
		}
		private function sendHandle():void
		{
			
		}
		private function shoutdownHandle():void
		{
			
		}
		private function aboutHandle():void
		{
			
		}
	}
}