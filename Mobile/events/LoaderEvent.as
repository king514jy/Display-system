package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Q·Jy
	 */
	public class LoaderEvent extends Event 
	{
		/**
		 * 解析完成
		 */
		public static const ANALYZE_OVER:String = "analyze_over";
		public static const COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		private var _progress:int;
		public function LoaderEvent(type:String,progress:int=0, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_progress = progress;
		} 
		public function get progress():int { return _progress; }
		public override function clone():Event 
		{ 
			return new LoaderEvent(type,progress, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}