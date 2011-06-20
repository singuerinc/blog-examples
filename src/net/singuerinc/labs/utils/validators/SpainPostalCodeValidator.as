package net.singuerinc.labs.utils.validators {

	/**
	 * @author nahuel.scotti / blog.singuerinc.net
	 */
	public class SpainPostalCodeValidator {

		public function validate(value:Object):Boolean {

			var str:String = value.toString();
			if (str.length != 5) return false;

			var regExp:RegExp = /((?>^[5]{1})[0-2][0-9]{3})|((?>^[0]{1})[1-9]{1}[0-9]{3})|((?>^[1-4]{1})[0-9]{1}[0-9]{3})$/;
			return regExp.test(str);
		}
	}
}