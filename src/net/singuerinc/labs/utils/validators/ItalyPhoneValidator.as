package net.singuerinc.labs.utils.validators {
	
	/**
	 * @author nahuel.scotti / blog.singuerinc.net
	 */
	public class ItalyPhoneValidator implements IPhoneValidator {

		private var operators:Array = ['TIM', 'Vodafone', 'Wind', 'Tre', 'TrenItalia'];

		private var _phoneNumber:String;
		private var _isValid:Boolean;
		private var _operatorIndex:int;
		private var _isFixed:Boolean;
		private var _isMobile:Boolean;

		private const TIM_REx:RegExp = /^((0039){0,1})3{1}(((?>3)[013456789]{1})|((?>6)[0368]{1}))[0-9]{7}$/;
		private const VODAFONE_REx:RegExp = /^((0039){0,1})3{1}(((?>4)[02356789]{1}))[0-9]{7}$/;
		private const WIND_REx:RegExp = /^((0039){0,1})3{1}(((?>2)[03789]{1})|((?>8)[0389]{1}))[0-9]{7}$/;
		private const TRE_REx:RegExp = /^((0039){0,1})3{1}9{1}[0-3]{1}[0-9]{7}$/;
		private const TRENITALIA_REx:RegExp = /^((0039){0,1})313[0-9]{7}$/;

		private var __rx:Array = [TIM_REx, VODAFONE_REx, WIND_REx, TRE_REx, TRENITALIA_REx];

		public function ItalyPhoneValidator(phoneNumber:String) {
			_phoneNumber = phoneNumber;
			_phoneNumber = _phoneNumber.replace(/^\+/, '00');
			_phoneNumber = _phoneNumber.replace(/[^0-9]/g, '');
			_isValid = validate(_phoneNumber);
		}

		public function isValid():Boolean {
			return _isValid;
		}

		public function get phoneNumber():String {
			return _phoneNumber;
		}

		public function get operatorName():String {
			return operators[_operatorIndex];
		}

		private function validate(value:String):Boolean {

			var str:String = value.toString();
			if (str.length < 10) {
				_operatorIndex = -1;
				return false;
			}

			var l:uint = __rx.length;
			for (var i:uint = 0; i < l; i++) {
				var success:Boolean = __rx[i].test(str);
				if (success) {
					_isMobile = true;
					_operatorIndex = i;
					return true;
				}
			}

			_isMobile = false;
			_operatorIndex = -1;
			return false;
		}

		public function isFixed():Boolean {
			return _isFixed;
		}

		public function isMobile():Boolean {
			return _isMobile;
		}
	}
}
