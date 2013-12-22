package controller
{
	import model.ConfigProxy;
	import model.WeatherPro;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadWeatherCmd extends SimpleCommand
	{
		public function LoadWeatherCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			var weatherPro:WeatherPro = this.facade.retrieveProxy(WeatherPro.NAME) as WeatherPro;
			var configPro:ConfigProxy = this.facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			weatherPro.loadData(configPro.city);
		}
	}
}