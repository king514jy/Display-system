package model
{
	import flash.events.DatagramSocketDataEvent;
	import flash.net.DatagramSocket;
	
	import ky.enumerate.MobileCommandMode;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class UdpProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "UdpProxy";
		
		private var datagramSocket:DatagramSocket = new DatagramSocket();
		public var requesterIP:String;
		public var requesterPort:int;
		public function UdpProxy(data:Object=null)
		{
			super(NAME, data);
		}
		public function start():void
		{
			if(datagramSocket.bound)
			{
				datagramSocket.close();
				datagramSocket = new DatagramSocket();
			}
			
			datagramSocket.bind(2013);
			datagramSocket.addEventListener(DatagramSocketDataEvent.DATA,dataReceived);
			datagramSocket.receive();
		}
		private function dataReceived(e:DatagramSocketDataEvent):void
		{
			//trace("Received from " + e.srcAddress + ":" + e.srcPort + "> " + 
				//e.data.readUTFBytes( e.data.bytesAvailable ) );
			requesterIP = e.srcAddress;
			requesterPort = e.srcPort;
			var message:String = e.data.readUTFBytes( e.data.bytesAvailable );
			var command:String = message.substr(0,4);
			var content:String = message.slice(4);
			trace(message+"&&"+command+"&&"+content)
			switch(command) 
			{
				case MobileCommandMode.GET_PLAY_LIST:
					this.sendNotification(DisplaySystemFacade.SEND_PLAY_LIST);
					break;
				case MobileCommandMode.CHANGE_MODULE:
					this.sendNotification(DisplaySystemFacade.CHANGE_MODULE,null,content);
					break;
			}
		}
		public function sendMessage(str:String):void
		{
			
		}
	}
}