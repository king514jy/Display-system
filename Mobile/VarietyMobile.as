package
{
	import com.kingclass.debug.Debug;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.DatagramSocketDataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	import events.LoaderEvent;
	
	import model.ConfigProxy;
	import model.UdpSever;
	
	import view.UIManage;
	import view.component.Bottom;
	import view.component.Image;
	import view.component.Item;
	import view.component.Title;
	
	import org.gestouch.core.Gestouch;
	import org.gestouch.input.NativeInputAdapter;

	public class VarietyMobile extends Sprite
	{
		private var udpSever:UdpSever;
		private var config:ConfigProxy;
		private var uiManage:UIManage;
		public function VarietyMobile()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//var pp:PerspectiveProjection = root.transform.perspectiveProjection;
			//pp.projectionCenter = new Point(stage.stageWidth * 0.5,stage.stageHeight * 0.5);
			//stage.transform.perspectiveProjection = pp;
			//Gestouch.inputAdapter = new NativeInputAdapter(stage);
			start();
		}
		private function start():void
		{
			udpSever = UdpSever.getInstance();
			udpSever.start();
			config = new ConfigProxy();
			config.addEventListener(LoaderEvent.COMPLETE,configComplete);
		}
		private function configComplete(e:LoaderEvent):void
		{
			uiManage = new UIManage();
			this.addChild(uiManage);
			uiManage.setData(config.icoList,config.nameList,config.codingList);
			this.addChild(new Debug());
		}
	}
}