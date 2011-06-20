package net.singuerinc.labs.utils.display {

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author nahuel.scotti
	 */
	public class DisplayUtils {

		public static function remove(obj:DisplayObject):void {
			try {
				obj.parent.removeChild(obj);
			} catch(e:Error) {

			}
		}

		public static function removeChilds(obj:DisplayObjectContainer):void {
			while (obj.numChildren > 0) {
				obj.removeChildAt(0);
			}
		}
	}
}
