package view.conmponents
{
	import flash.events.EventDispatcher;
	
	import ky.enumerate.CutoverMode;
	
	public class ModuleFactory extends EventDispatcher
	{
		private var codingList:Vector.<String>;
		private var _mode:String;
		private var nowID:int;
		public function ModuleFactory(codingList:Vector.<String>,mode:String="0")
		{
			this.codingList = codingList;
			_mode = mode;
		}
		public function set mode(str:String):void{ _mode = str; }
		public function get mode():String{ return _mode; }
		public function get coding():String
		{
			var str:String;
			switch(_mode)
			{
				case CutoverMode.ORDER:
					str = codingList[nowID];
					nowID++;
					if(nowID == codingList.length)
						nowID = 0;
					break;
				case CutoverMode.RANDOM:
					str = codingList[Math.floor(Math.random() * codingList.length)];
					break;
			}
			return str;
		}
	}
}