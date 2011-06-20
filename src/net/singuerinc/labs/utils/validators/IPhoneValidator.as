package net.singuerinc.labs.utils.validators {
	/**
	 * @author nahuel.scotti
	 */
	public interface IPhoneValidator {

		function isValid():Boolean;

		function isFixed():Boolean;

		function isMobile():Boolean;
	}
}
