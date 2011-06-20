package net.singuerinc.labs.utils.validators {
	/**
	 * @author nahuel.scotti
	 */
	public class SpainDNIValidator {

		private var _dni:String;

		private var _isNie:Boolean;
		private var _isNif:Boolean;
		private var _valid:Boolean;

		private const validChars:String = 'TRWAGMYFPDXBNJZSQVHLCKET';
		private const nifRexp:RegExp = /^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKET]{1}$/i;
		private const nieRexp:RegExp = /^[XYZ]{1}[0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKET]{1}$/i;

		public function SpainDNIValidator(dni:String) {
			_dni = dni;
			_valid = _validate();
		}

		public function isValid():Boolean {
			return _valid;
		}

		public function isNIF():Boolean {
			return _isNif;
		}

		public function isNIE():Boolean {
			return _isNie;
		}

		private function _validate():Boolean {

			var val:String = _dni.toString().toUpperCase();

			if (!nifRexp.test(val) && !nieRexp.test(val)) {
				return false;
			}

			var nie:String = val;
			nie = nie.replace(/^[X]/, '0');
			nie = nie.replace(/^[Y]/, '1');
			nie = nie.replace(/^[Z]/, '2');

			var dniLetter:String = val.substr(-1);
			var charIndex:int = int(nie.substr(0, 8)) % 23;

			if (validChars.charAt(charIndex) == dniLetter) {

				_isNif = nifRexp.test(val);
				_isNie = nieRexp.test(val);

				return true;
			}

			return false;
		}
	}
}