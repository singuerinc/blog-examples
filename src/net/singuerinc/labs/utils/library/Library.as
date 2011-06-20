package net.singuerinc.labs.utils.library {

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	/**
	 * @author nahuel.scotti
	 */
	public class Library {

		private static var _libraries:Dictionary = new Dictionary();

		public static function add(libraryID:String, library:*):void{
			_libraries[libraryID] = library;
		}

		public static function extract(libraryID:String):*{
			return _libraries[libraryID];
		}
		
		public static function remove(libraryID:String):void{
			delete _libraries[libraryID];
		}
		
		public static function soundFrom(itemID:String, libraryID:String):Sound {

			var Clazz:Class = classFrom(itemID, libraryID) as Class;
			var item:Sound = new Clazz() as Sound;
			return item;
		}

		public static function spriteFrom(itemID:String, libraryID:String):Sprite {

			var Clazz:Class = classFrom(itemID, libraryID) as Class;
			var item:Sprite = new Clazz() as Sprite;
			return item;
		}

		public static function movieClipFrom(itemID:String, libraryID:String):MovieClip {

			var Clazz:Class = classFrom(itemID, libraryID) as Class;
			var item:MovieClip = new Clazz() as MovieClip;
			return item;
		}

		public static function mixWithClassIn(clazz:Class, libraryID:String):* {
			var itemID:String = String(describeType(clazz).@name).replace('::', '.');
			var Clazz:Class = classFrom(itemID, libraryID) as Class;
			var item:Sprite = new Clazz() as Sprite;
			return item;
		}

		public static function classFrom(className:String, libraryID:String):Class {
			var Clazz:Class = _libraries[libraryID].loaderInfo.applicationDomain.getDefinition(className) as Class;
			return Clazz;
		}

		public static function classFromSWF(className:String, swf:DisplayObject):Class {
			var Clazz:Class = swf.loaderInfo.applicationDomain.getDefinition(className) as Class;
			return Clazz;
		}
	}
}