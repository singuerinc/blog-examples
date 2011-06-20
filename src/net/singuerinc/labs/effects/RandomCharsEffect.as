package net.singuerinc.labs.effects {

	import org.osflash.signals.Signal;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	/**
	 * @author nahuel.scotti
	 */
	public class RandomCharsEffect {

		private var _numIterations:uint = 10;
		// ms
		private var _updateTime:uint = 20;
		// ms

		public var chars:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"·$%&/=?^*';

		private var _chars:Array;
		private var _i:uint;
		private var _a:Number;
		private var _str:String;

		private var _changed:Signal;
		private var _completed:Signal;

		private var _nChars:Array;
		private var _numChars:uint;

		private var _updateLabelFunction:Function;

		// private var _intv:uint;

		public function RandomCharsEffect(text:String, numIterations:uint = 5, updateTime:uint = 40) {
			// }
			//
			//
			// public function play(text:String, numIterations:uint = 5, updateTime:uint = 40):void {

			_updateTime = updateTime;

			_chars = text.split('');
			_nChars = _chars.slice();
			_numChars = _chars.length;

			_numIterations = Math.max(numIterations, _numChars);

			_updateLabelFunction = updateLabel2;

			_i = 0;
			_a = 0;
			// _intv = setInterval(update, updateTime);
		}

		public function update():void {

			_a += 1 / _numIterations;

			if (_a >= _chars.length) {
				// clearInterval(_intv);
				completed.dispatch(_str);
			}

			_updateLabelFunction();
		}

		// public function stop():void {
		// completed.dispatch(_str);
		// }

		public function get completed():Signal {
			return _completed ||= new Signal(String);
		}

		public function get changed():Signal {
			return _changed ||= new Signal(String);
		}


		private function updateLabel1():void {

			if (_i == Math.floor(_a)) {
				_str = _chars.slice(0, _i).join('');
				_i++;
			} else {
				_str = _chars.slice(0, _i - 1).join('') + randomChar();
			}
			changed.dispatch(_str);
		}

		private function updateLabel2():void {

			if (_i == Math.floor(_a)) {
				_nChars[_i] = _chars[_i];
				for (var i:uint = _i + 1; i < _numChars; i++) {
					_nChars[i] = randomChar();
				}
				_i++;
				_numIterations -= _numIterations / _numChars;
			} else {

				for (var j:uint = _i; j < _numChars; j++) {
					_nChars[j] = randomChar();
				}
			}
			changed.dispatch(_nChars.join(''));
		}

		private function randomChar():String {
			var l:uint = chars.length;
			return chars.split('')[int(Math.random() * l)];
		}
	}
}