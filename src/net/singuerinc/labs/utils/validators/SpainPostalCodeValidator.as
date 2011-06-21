package net.singuerinc.labs.utils.validators {
	/**
	 * @author blog.singuerinc.net
	 */
	public class SpainPostalCodeValidator {

		public var stateNames:Array = ['Alava/Araba', 'Albacete', 'Alicante', 'Almería', 'Avila', 'Badajoz', 'Islas Baleares', 'Barcelona', 'Burgos', 'Cáceres', 'Cádiz', 'Castellón', 'Ciudad Real', 'Córdoba', 'A Coruña/La Coruña', 'Cuenca', 'Gerona/Girona', 'Granada', 'Guadalajara', 'Gipuzkoa/Guipuzcoa', 'Huelva', 'Huesca', 'Jaen', 'León', 'Lérida/Lleida', 'La Rioja', 'Lugo', 'Madrid', 'Málaga', 'Murcia', 'Navarra', 'Orense/Ourense', 'Asturias', 'Palencia', 'Las Palmas', 'Pontevedra', 'Salamanca', 'S.C.Tenerife', 'Cantabria', 'Segovia', 'Sevilla', 'Soria', 'Tarragona', 'Teruel', 'Toledo', 'Valencia', 'Valladolid', 'Bizkaia/Vizcaya', 'Zamora', 'Zaragoza', 'Ceuta', 'Melilla'];

		private var _stateName:String;
		private var _stateCode:String;
		private var _isValid:Boolean;

		public function SpainPostalCodeValidator(codeOrStateName:String) {
			if (isNaN(Number(codeOrStateName)) == true) {
				var result:String = search(codeOrStateName);
				if (result == '') {
					_isValid = false;
				} else {
					result += '000';
					_isValid = validate(result);
				}
			} else {
				_isValid = validate(codeOrStateName);
			}
		}

		public function get stateCode():String {
			return _stateCode;
		}

		public function get stateName():String {
			return _stateName;
		}

		public function isValid():Boolean {
			return _isValid;
		}

		private function validate(value:String):Boolean {

			var str:String = value.toString();
			if (str.length != 5) return false;

			var regExp:RegExp = /((?>^[5]{1})[0-2][0-9]{3})|((?>^[0]{1})[1-9]{1}[0-9]{3})|((?>^[1-4]{1})[0-9]{1}[0-9]{3})$/;
			var result:Boolean = regExp.test(str);
			if (result) {
				var codeInit:String = str.substr(0, 2);
				var idx:uint = Number(codeInit);
				_stateName = stateNames[idx - 1];
				_stateCode = codeInit;
			}

			return result;
		}

		private function search(stateName:String):String {

			stateName = stateName.toLowerCase();
			var state:int = -1;

			var l:uint = stateNames.length;
			for (var i:uint = 0; i < l; i++) {
				var s:String = stateNames[i];
				if (s.toLowerCase().search(stateName) != -1) {
					state = i;
					break;
				}
			}
			return state == -1 ? '' : ('0' + (state + 1)).substr(-2);
		}
	}
}