package net.singuerinc.labs.utils.time {

	import org.osflash.signals.Signal;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * @author nahuel.scotti
	 */
	public class Lap {

		public var initDate:Date;
		public var currentDate:Date;
		public var finalDate:Date;

		private var _timer:Timer;
		private var _initTime:Number;
		private var _finalTime:int;
		private var _currentTime:int;
		private var _totalTime:int;
		private var _elapsedTime:int;
		private var _remainingTime:int;
		private var _start:int;

		public function Lap(initDate:Date, finalDate:Date, currentDate:Date = null) {

			_start = getTimer();

			this.initDate = initDate;
			this.finalDate = finalDate;
			this.currentDate = currentDate || new Date();

			_initTime = initDate.time;
			_finalTime = finalDate.time;

			_totalTime = _finalTime - _initTime;
			_currentTime = this.currentDate.time;
			_remainingTime = _finalTime - _currentTime;
		}

		public function start():void {
			_timer = new Timer(250);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
		}

		private function onTimer(event:TimerEvent):void {

			if (_remainingTime <= 0) {
				stop();
				return;
			}

			currentDate.setMilliseconds(currentDate.getMilliseconds() + 250);

			_currentTime = currentDate.time;
			_elapsedTime = _currentTime - _initTime;
			_remainingTime = _finalTime - _currentTime;

			changed.dispatch(this);
		}

		public function stop():void {
			if (_timer) {
				_timer.stop();
			}
		}

		public function get elapsedPercent():Number {
			var ep:Number = (_elapsedTime * 100) / _totalTime;
			return ep;
		}

		public function get elapsedDate():Date {
			return new Date(_elapsedTime);
		}

		public function get remainingDate():Date {
			return new Date(_remainingTime);
		}

		private var _changed:Signal;

		public function set changed(value:Signal):void {
			_changed = value;
		}

		public function get changed():Signal {
			return _changed ||= new Signal(Lap);
		}
	}
}
