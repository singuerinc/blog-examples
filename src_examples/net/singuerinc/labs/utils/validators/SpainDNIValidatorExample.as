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
	public class SpainDNIValidatorExample extends Sprite {

		private var _it:InputText;
		private var _pb:PushButton;
		private var _valid_lbl:Label;
		private var _isNIF_lbl:Label;
		private var _isNIE_lbl:Label;

		public function SpainDNIValidatorExample() {

			// var val1:SpainDNIValidator = new SpainDNIValidator('x9464186p');
			// val1.isValid();
			// val1.isNIF();
			// val1.isNIE();
			//
			// var val2:SpainDNIValidator = new SpainDNIValidator('12345678Z');
			// val2.isValid();
			// val2.isNIF();
			// val2.isNIE();

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_it = new InputText(this, 10, 10, '12345678Z');
			_pb = new PushButton(this, 10, 35, 'validate', validatePhone);
			_valid_lbl = new Label(this, 150, 10, 'isValid:');
			_isNIF_lbl = new Label(this, 150, 25, 'isNIF:');
			_isNIE_lbl = new Label(this, 150, 40, 'isNIE:');
		}

		private function validatePhone(event:MouseEvent):void {
			var val1:SpainDNIValidator = new SpainDNIValidator(_it.text);
			_valid_lbl.text = 'isValid: ' + val1.isValid();
			_isNIF_lbl.text = 'isNIF: ' + val1.isNIF();
			_isNIE_lbl.text = 'isNIE: ' + val1.isNIE();
		}

	}
}
