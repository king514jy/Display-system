package view.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bottom extends Sprite
	{
		private var bottomMc:Sprite;
		private var copyrightMc:Sprite;
		public function Bottom()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			bottomMc = this.getChildByName("bottom_mc") as Sprite;
			copyrightMc = this.getChildByName("copyright_mc") as Sprite;
			//bottomMc.width = stage.stageWidth;
			//copyrightMc.x = (stage.stageWidth - copyrightMc.width) * 0.5;
		}
	}
}