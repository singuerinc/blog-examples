package net.singuerinc.labs.effects {

	import flash.events.Event;
	import com.greensock.easing.Quad;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	[SWF(backgroundColor="#121212", frameRate="60", width="640", height="480")]
	public class RandomCharsExample extends Sprite {

		private var _textfield:TextField;
		private var _eff:RandomCharsEffect;

		public function RandomCharsExample() {

			_textfield = new TextField();
			_textfield.defaultTextFormat = new TextFormat('Helvetica Neue', 32, 0x565656);
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textfield);

			_eff = new RandomCharsEffect('SinguerInc');
			_eff.changed.add(onEffectChange);
			_eff.completed.add(onEffectStopped);

			stage.addEventListener(Event.ENTER_FRAME, onEF);
		}

		private function onEF(event:Event):void {
			_eff.update();
		}

		private function onEffectStopped(str:String):void {
			// _eff.stop();
			stage.removeEventListener(Event.ENTER_FRAME, onEF);
		}

		private function onEffectChange(str:String):void {
			_textfield.text = str;
		}
	}
}
