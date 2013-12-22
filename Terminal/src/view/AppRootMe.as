package view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.conmponents.AppRoot;
	
	public class AppRootMe extends Mediator implements IMediator
	{
		public static const NAME:String = "AppRootMe";
		private var appRoot:AppRoot;
		public function AppRootMe(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			appRoot = AppRoot.getInstance();
		}
	}
}