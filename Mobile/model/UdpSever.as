package model
{
	import flash.events.DatagramSocketDataEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	public class UdpSever extends EventDispatcher
	{
		public static var udpSever:UdpSever;
		
		private var datagramSocket:DatagramSocket = new DatagramSocket();
		public function UdpSever()
		{
			
		}
		public static function getInstance():UdpSever
		{
			if(!udpSever)
				udpSever = new UdpSever();
			return udpSever;
		}
		public function start():void
		{
			if( datagramSocket.bound ) 
			{
				datagramSocket.close();
				datagramSocket = new DatagramSocket();
				
			}
			datagramSocket.bind( 2046 );
			datagramSocket.addEventListener( DatagramSocketDataEvent.DATA, dataReceived );
			datagramSocket.receive();
		}
		private function dataReceived(e:DatagramSocketDataEvent):void
		{
			
		}
		public function sendMessage(str:String,ip:String):void
		{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes( str );
			datagramSocket.send( data, 0, 0, ip, 2046);
		}
	}
}