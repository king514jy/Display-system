package view.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Title extends Sprite
	{
		private var bottomMc:Sprite;
		private var titleMc:Sprite;
		public function Title()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			bottomMc = this.getChildByName("bottom_mc") as Sprite;
			titleMc = this.getChildByName("title_mc") as Sprite;
			bottomMc.width = stage.stageWidth;
			titleMc.x = (stage.stageWidth - titleMc.width) * 0.5;
		}
	}
}