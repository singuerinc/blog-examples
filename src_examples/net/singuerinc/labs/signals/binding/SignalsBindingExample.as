package net.singuerinc.labs.signals.binding {

	import com.bit101.components.PushButton;
	import org.osflash.signals.binding.Binder;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class SignalsBindingExample extends Sprite {

		public var user:User;

		public function SignalsBindingExample() {

			new PushButton(this, 0, 20, 'change user name', onClick);

			var txt1:TextField = new TextField();
			txt1.autoSize = TextFieldAutoSize.LEFT;
			addChild(txt1);

			user = new User();
			user.name = 'User1';

			var binder:Binder = new Binder();
			binder.bind(txt1, 'text', user, 'name');
		}

		private function onClick(event:MouseEvent):void {
			user.name = 'User' + Math.random();
		}
	}
}