package events
{
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		public static const SEND_MESSAGE:String = "send_message";
		private var _message:String;
		public function MessageEvent(type:String,message:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = message;
		}
		public function get message():String{ return _message; }
	}
}