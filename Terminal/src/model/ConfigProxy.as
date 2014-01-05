package model
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import deng.fzip.FZip;
	
	import model.vo.FixAnimationValue;
	import model.vo.ModuleItem;
	import model.vo.PlayItem;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ConfigProxy extends Proxy implements IProxy
	{
		public static const NAME:String="ConfigProxy";
		
		public var moduleList:Vector.<ModuleItem>;
		public var playList:Vector.<PlayItem>;
		public var cutoverValue:String;
		public var defaultCoding:String;
		public var animationValue:String;
		public var intervalValue:Number;
		public var fixAnimationValue:FixAnimationValue;
		public var ip:String;
		public var city:String;
		public var modify:Number;
		private var separator:String;
		private var playListXML:XML;
		public function ConfigProxy(data:Object=null)
		{
			super(NAME,data);
		}
		public function loadConfig():void
		{
			separator = File.separator;
			//var file:File = File.applicationStorageDirectory.resolvePath("module/");
			var file:File = File.applicationDirectory.resolvePath("module/");
			//trace(file.nativePath)
			var url:String;
			//if(!file.exists)
			//{
				//var file2:File = File.applicationDirectory.resolvePath("module/");
				//file2.copyTo(file,true);
			//}
			playListXML = <data></data>
			url = file.url+File.separator+"config.xml";
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(Event.COMPLETE,complete);
		}
		private function complete(e:Event):void
		{
			var urlLoader:URLLoader = e.target as URLLoader;
			var xml:XML = XML(urlLoader.data);
			cutoverValue = xml.system.playSet.cutover.@value;
			defaultCoding = xml.system.playSet.cutover.defaultPlay.@coding;
			animationValue = xml.system.playSet.animation.@value;
			intervalValue = Number(xml.system.playSet.interval);
			fixAnimationValue = new FixAnimationValue();
			fixAnimationValue.switchBtn = xml.system.fixAnimation.@switchBtn=="true";
			fixAnimationValue.hour = Number(xml.system.fixAnimation.time.@hour);
			fixAnimationValue.minute = Number(xml.system.fixAnimation.time.@minute);
			fixAnimationValue.coding = xml.system.fixAnimation.defaultPlay.@coding;
			ip = xml.system.ip;
			city = xml.system.address.@city;
			modify = Number(xml.modify);
			moduleList = new Vector.<ModuleItem>();
			playList = new Vector.<PlayItem>();
			var moLe:uint = xml.moduleList.item.length();
			var playLe:uint = xml.playList.item.length();
			playListXML.appendChild(xml.playList);
			for(var i:int=0;i<moLe;i++)
			{
				var moItem:ModuleItem = new ModuleItem();
				moItem.name = xml.moduleList.item[i].@name;
				moItem.coding = xml.moduleList.item[i].@coding;
				moItem.switchBtn = xml.moduleList.item[i].@switchBtn=="true";
				moItem.config = xml.moduleList.item[i].@config=="true";
				moduleList.push(moItem);
			}
			for(var j:int=0;j<playLe;j++)
			{
				var playItem:PlayItem = new PlayItem();
				playItem.name = xml.playList.item[j].@name;
				playItem.coding = xml.playList.item[j].@coding;
				playList.push(playItem);
			}
			this.sendNotification(DisplaySystemFacade.INIT);
		}
		public function getPlayListZip():ByteArray
		{
			var data:ByteArray = new ByteArray();
			var fzip:FZip = new FZip();
			var le:int = playList.length;
			for(var i:int=0;i<=le;i++)
			{
				var byt:ByteArray = new ByteArray();
				if(i!=le)
				{
					var file:File = File.applicationStorageDirectory.resolvePath("module"+separator+playList[i].coding+separator+"ico.png");
					var fs:FileStream = new FileStream();
					fs.open(file,FileMode.READ);
					fs.readBytes(byt);
					fzip.addFile(playList[i].coding+"ico.png",byt);
				}
				else
				{
					byt.writeUTFBytes(playListXML.toString());
					fzip.addFile("playList.xml",byt);
				}
			}
			fzip.serialize(data);
			return data;
		}
	}
}