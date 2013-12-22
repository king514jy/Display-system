package
{
	import controller.StartCmd;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	public class DisplaySystemFacade extends Facade implements IFacade
	{
		public static const START:String = "start";
		public static const LOAD_CONFIG:String = "load_config";
		public static const INIT:String = "init";
		public static const GET_WEATHER:String = "get_weather";
		public static const LOAD_WEATHER_COMPLETE:String = "load_weather_complete";
		public static const START_SOCKET:String = "start_socket";
		public static const SEND_PLAY_LIST:String = "send_play_list";
		public static const CHANGE_MODULE:String = "change_module";
		
		public static var instance:DisplaySystemFacade;
		public function DisplaySystemFacade()
		{
			//TODO: implement function
			super();
		}
		public static function getInstance():DisplaySystemFacade
		{
			if(!instance)
				instance = new DisplaySystemFacade();
			return instance;
		}
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(START,StartCmd);
		}
		public function startup():void
		{
			sendNotification(START);
		}
	}
}