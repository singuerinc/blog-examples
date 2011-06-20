package net.singuerinc.labs.utils.validators {

	/**
	 * @author nahuel.scotti / blog.singuerinc.net
	 */
	public class SpainPhoneValidator implements IPhoneValidator {

		private var _isMobile:Boolean;
		private var _isFixed:Boolean;
		private var _isValid:Boolean;

		public function SpainPhoneValidator(tel:String) {
			_isValid = _validate(tel);
		}

		private function _validate(value:Object):Boolean {

			var str:String = value.toString();
			str = str.replace(/\s/g, '');
			if (str.length != 9) return false;

			var regExp:RegExp = /^[679]{1}[0-9]{8}$/;
			var result:Boolean = regExp.test(str);

			if (result) {
				_isFixed = /^[9]/.test(str);
				_isMobile = /^[67]/.test(str);
			}

			return result;
		}

		public function isValid():Boolean {
			return _isValid;
		}

		public function isFixed():Boolean {
			return _isFixed;
		}

		public function isMobile():Boolean {
			return _isMobile;
		}
	}
}