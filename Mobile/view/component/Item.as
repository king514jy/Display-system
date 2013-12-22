package view.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class Item extends Sprite
	{
		private var icoGroup:Sprite;
		private var nameTxt:TextField;
		//private var switchBtn
		private var _ico:Image;
		private var _coding:String;
		public function Item()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function set ico(img:Image):void
		{
			_ico = img;
			icoGroup.removeChildren();
			icoGroup.addChild(img);
		}
		public function get ico():Image{ return _ico; }
		public function set title(str:String):void{ nameTxt.text = str; }
		public function get title():String{ return nameTxt.text; }
		public function set coding(str:String):void{ _coding = str; }
		public function get coding():String{ return _coding; }
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			icoGroup = this.getChildByName("ico_group_mc") as Sprite;
			nameTxt = this.getChildByName("name_txt") as TextField;
		}
		
	}
}