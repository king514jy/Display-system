package ky.module.time
{	
	public class TimeBase
	{
		private var dateData:Date;
		private var dayList:Vector.<String>;
		public function TimeBase()
		{
			dateData = new Date();
			dayList = new Vector.<String>();
			dayList.push("日","一", "二", "三", "四", "五", "六");
		}
		public function get date():String
		{
			var dateN:Number=dateData.getDate();
			var dateStr:String;
			if (dateN < 10)
				dateStr = "0" + String(dateN);
			else
				dateStr = String(dateN);
			return dateStr;
		}
		public function get month():String
		{
			var monthN:Number = dateData.getMonth()+1;
			var monthStr:String;
			if(monthN < 10)
				monthStr = "0" + String(monthN);
			else
				monthStr = String(monthN);
			return monthStr;
		}
		public function get year():String{ return String(dateData.getFullYear()); }
		public function get chinaDay():String{ return "星期" + dayList[dateData.getDay()]; }
		
	}
}