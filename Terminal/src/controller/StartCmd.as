package controller
{
	import model.ConfigProxy;
	import model.UdpProxy;
	import model.WeatherPro;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.AppRootMe;
	import view.DisplayBoxMe;

	public class StartCmd extends SimpleCommand
	{
		public function StartCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			this.facade.registerProxy(new ConfigProxy());
			this.facade.registerProxy(new UdpProxy());
			this.facade.registerProxy(new WeatherPro());
			
			this.facade.registerMediator(new AppRootMe());
			this.facade.registerMediator(new DisplayBoxMe());
			
			this.facade.registerCommand(DisplaySystemFacade.LOAD_CONFIG,LoadConfigCmd);
			this.facade.registerCommand(DisplaySystemFacade.INIT,InitCmd);
			this.facade.registerCommand(DisplaySystemFacade.GET_WEATHER,GetWeatherCmd);
			this.facade.registerCommand(DisplaySystemFacade.SEND_PLAY_LIST,SendPlayListCmd);
			this.facade.registerCommand(DisplaySystemFacade.CHANGE_MODULE,ChangeModuleCmd);
			
			this.sendNotification(DisplaySystemFacade.LOAD_CONFIG);
		}
	}
}