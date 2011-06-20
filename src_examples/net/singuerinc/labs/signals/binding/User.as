package net.singuerinc.labs.signals.binding {

	import org.osflash.signals.binding.ChangeSignal;
	import org.osflash.signals.binding.IBindable;
	import org.osflash.signals.binding.IChangeSignal;

	public class User implements IBindable {

		private var _name:String;
		private var _changeSignal:ChangeSignal;

		public function User() {
		}

		public function set name(value:String):void {
			_name = value;
			changeSignal.dispatch('name', _name);
		}

		public function get name():String {
			return _name;
		}

		public function get changeSignal():IChangeSignal {
			return _changeSignal ||= new ChangeSignal(this);
		}
	}
}
