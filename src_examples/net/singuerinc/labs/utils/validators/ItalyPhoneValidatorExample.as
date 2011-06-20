package net.singuerinc.labs.utils.validators {

	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	/**
	 * @author nahuel.scotti
	 */
	[SWF(backgroundColor="#CDCDCD", frameRate="31", width="400", height="85")]
	public class ItalyPhoneValidatorExample extends Sprite {

		private var _it:InputText;
		private var _valid_lbl:Label;
		private var _operator_lbl:Label;
		private var _isMobile_lbl:Label;
		private var _pb:PushButton;

		public function ItalyPhoneValidatorExample() {

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_it = new InputText(this, 10, 10, '+39 380 1234567');
			_pb = new PushButton(this, 10, 35, 'validate', validatePhone);
			_valid_lbl = new Label(this, 150, 10, 'isValid:');
			_operator_lbl = new Label(this, 150, 25, 'operatorName:');
			_isMobile_lbl = new Label(this, 150, 40, 'isMobile:');
		}

		private function validatePhone(event:MouseEvent):void {
			var val1:ItalyPhoneValidator = new ItalyPhoneValidator(_it.text);
			_valid_lbl.text = 'isValid: ' + val1.isValid();
			_operator_lbl.text = 'operatorName: ' + val1.operatorName;
			_isMobile_lbl.text = 'isMobile: ' + val1.isMobile();
		}

	}
}
