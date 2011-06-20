package net.singuerinc.labs.utils.time
{
	public class TimeUtils
	{
		public static function milisecondsAsClockString(ms:Number):String
		{
			var time:Number = ms / 1000;
			var sec:uint = time % 60;
			var mins:uint = ( time / 60 ) % 60 ;
			var hours:uint =  ( time  / 60 ) / 60;
			
			var _hours:String = "0" + hours;
			var _mins:String = "0" + mins;
			var _secs:String = "0" + sec;
			
			return ( _hours.substr(-2) + ":" + _mins.substr(-2) + ":" + _secs.substr(-2) );
		
		}
		
		public static function dateWith2digits(day:uint, month:uint, year:uint):String
		{
			var _day:String = "0" + day;
			var _month:String = "0" + (month+1);
			var _year:String = "0" + year;
			
			return ( _day.substr(-2) + "/" + _month.substr(-2) + "/" + _year.substr(-2) );
		
		}
		
		public static function timeWith2digits(hours:uint, mins:uint, secs:uint):String
		{
			var _hours:String = "0" + hours;
			var _mins:String = "0" + mins;
			var _secs:String = "0" + secs;
			
			return ( _hours.substr(-2) + ":" + _mins.substr(-2) + ":" + _secs.substr(-2) );
		
		}
		
		public static function dateTo_DDMMYY_HHMMSS(date:Date):String
		{
			var _date:String = dateWith2digits(date.date, date.month, date.fullYear);
			var _time:String = timeWith2digits(date.hours, date.minutes, date.seconds);
			
			return _date + ' - ' + _time;
		
		}	
	}
}