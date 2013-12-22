package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.events.DatagramSocketDataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	import view.component.Bottom;
	import view.component.Image;
	import view.component.Item;
	import view.component.Title;

	public class VarietyMobile extends Sprite
	{
		private var bottom:Bottom;
		private var ar:Array = new Array("永生花·天气ui一","永生花·天气ui二","永生花·预告片");
		private var datagramSocket:DatagramSocket = new DatagramSocket();
		public function VarietyMobile()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			if( datagramSocket.bound ) 
			{
				datagramSocket.close();
				datagramSocket = new DatagramSocket();
				
			}
			datagramSocket.bind( 2013 );
			datagramSocket.addEventListener( DatagramSocketDataEvent.DATA, dataReceived );
			datagramSocket.receive();
			this.addChild(new Title());
			bottom = new Bottom();
			bottom.y = stage.stageHeight;
			this.addChild(bottom);
			for(var i:int=0;i<3;i++)
			{
				var item:Item = new Item();
				item.y = 82+(i * 102);
				this.addChild(item);
				trace()
				item.ico = new Image("assets/ico"+i+".png");
				item.name = ar[i];
				item.coding = String(i);
				item.addEventListener(MouseEvent.CLICK,clickHandle);
			}
		}
		private function clickHandle(e:MouseEvent):void
		{
			var item:Item = e.currentTarget as Item;
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes( "0002"+item.coding );
			datagramSocket.send( data, 0, 0, "192.168.1.200", 2013);
		}
		private function dataReceived(e:DatagramSocketDataEvent):void
		{
			
		}
	}
}