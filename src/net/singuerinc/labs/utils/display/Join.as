package net.singuerinc.labs.utils.display {

	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * <p>La classe <code>Join</code> nos permite unir 2 o m&acute;s objetos entre si
	 * utilizando diferentes tipos de alineaciones y parametros para definir el tipo de
	 * uni&oacute;n.</p>
	 *
	 * @author nahuel.scotti
	 */
	public class Join {

		/**
		 * <p>Se emite cada vez que se realiza una uni&oacute;n.
		 * De este modo se puede capturar y realizar otra accio&oacute;n.</p>
		 *
		 * @return Signal
		 */
		public var onJoin:Signal;

		/**
		 * <p>Define el tipo de uni&oacute;n hacia la derecha.</p>
		 */
		public static const TO_RIGHT:String = "right";
		/**
		 * <p>Define el tipo de uni&oacute;n hacia la izquierda.</p>
		 */
		public static const TO_LEFT:String = "left";
		/**
		 * <p>Define el tipo de uni&oacute;n hacia arriba.</p>
		 */
		public static const TO_TOP:String = "top";
		/**
		 * <p>Define el tipo de uni&oacute;n hacia abajo.</p>
		 */
		public static const TO_BOTTOM:String = "bottom";

		private var _vars:Object;
		private var _refObj:DisplayObject;
		private var _gap:uint;
		private var _fixedSize:Number;
		private var _isFixedSize:Boolean;
		private var _autoAlign:Boolean;
		private var _direction:String;
		private var _objects:Array;
		private var _copyOfObjects:Array;

		/**
		 * <p>Constructor</p>
		 *
		 * @see #join()
		 * @see Join#joinTo()
		 *
		 * @param direction La direcci&oacute;n a la que se unen los objetos
		 * @param refObj Es el objeto "referencia" y se unir&aacute;n a este el o los otros objetos.
		 * @param vars Un objeto que parametriza la uni&oacute;n, propiedades como "fixedSize", "gap" y "autoAlign" se pueden definir aqu&iacute;.
		 */
		public function Join(direction:String, refObj:DisplayObject, vars:Object = null) {

			onJoin = new Signal(Join);

			_vars = vars || {};

			this.objects = [];
			this.refObj = refObj;
			this.direction = direction;
			this.fixedSize = (_vars.fixedSize != undefined) ? _vars.fixedSize : NaN;
			this.gap = (_vars.gap != undefined) ? _vars.gap : 0;
			this.autoAlign = (_vars.autoAlign != undefined) ? _vars.autoAlign : true;
			this.round = (_vars.round != undefined) ? _vars.round : false;
		}

		/**
		 * <p>Se utiliza para agregar uno o m&acute;s elementos a la uni&oacute;n.<br/>
		 * Hay que tener en cuenta que los objetos se unir&aacute;n en el orden que se
		 * vayan agregando al objeto <code>Join</code>.</p>
		 *
		 * @param obj1 El <code>DisplayObject</code> que se quiere unir.
		 * @param rest Permite agregar m&aacute;s objetos a la union.
		 *
		 * @return uint La cantidad de objetos que est&aacute;n listo para unirse.
		 */
		public function add(obj1:DisplayObject, ...rest):uint {
			objects.push(obj1);
			var l:uint = rest.length;
			for (var i:uint = 0; i < l; i++) {
				var thisObj:DisplayObject = rest[i];
				if (thisObj == refObj) continue;
				if (objects.indexOf(thisObj) == -1) {
					objects.push(thisObj);
				}
			}
			return objects.length;
		}

		/**
		 * <p>Une uno o m&aacute;s objetos en relaci&oacute;n a uno que se coge como referencia.</p>
		 * <p><em>Todos los objetos deben tener el mismo <code>parent</code>.</em></p>
		 *
		 * @see #childs()
		 * @see Join#joinTo()
		 * @return Un objeto Join si se realiza correctamente la uni&oacute;n.
		 *
		 * @example
		 * <listing version="3.0">
		 * var j:Join = new Join(Join.DIRECTION_LEFT, _displayObj1, {gap: 10});
		 * j.add(_displayObj2);
		 * j.join();
		 * // o...con varios objetos
		 * var j:Join = new Join(Join.DIRECTION_RIGHT, {gap: 25});
		 * j.add(_displayObj1, _displayObj2, _displayObj3, _displayObj4, _displayObj5);
		 * j.join();
		 * </listing>
		 *
		 */
		public function join():Join {
			var success:Boolean = __joinObject();
			return (success) ? this : null;
		}



		// // // // ///////////////////////////////
		// STATIC
		// // // // ///////////////////////////////

		/**
		 * @copy #join()
		 * @see #join()
		 *
		 * @example
		 * <listing version="3.0">
		 * Join.joinTo(obj1, obj2, Join.DIRECTION_LEFT, {gap: 10});
		 * </listing>
		 */
		public static function joinTo(refObj:DisplayObject, obj:DisplayObject, direction:String, vars:Object = null):Join {

			var j:Join = new Join(direction, refObj, vars);
			j.add(obj);
			return j.join();

		}

		/**
		 * <p>Permite de forma r&aacute;pida unir varios objetos.</p>
		 *
		 * @param refObj
		 * @param objs Un <code>Array</code> con varios elementos.
		 * @param direction El tipo de uni&oacute;n que se quiere realizar.
		 * @param vars Un objeto que define otras opciones para la uni&oacute;n.
		 */
		public static function joinAllTo(refObj:DisplayObject, objs:Array, direction:String, vars:Object = null):Join {
			var j:Join = new Join(direction, refObj, vars);
			j.add.apply(j, objs);
			return j.join();
		}

		/**
		 * <p>Une todos los objetos que se encuentran dentro de un container.</p>
		 * <p>El objeto que se coge como referencia para la uni&oacute;n es <code>container.getChildAt(0)</code>.</p>
		 *
		 * @param container Un objeto que contiene otros objetos que se unir&aacute;n.
		 * @see #join()
		 * @return Un objeto Join si se realiza correctamente la uni&oacute;n.
		 *
		 * @example
		 * <listing version="3.0">
		 * trace(_displayObjContainer.numChildren); // 3
		 * Join.joinChildsOf(_displayObjContainer, Join.DIRECTION_DOWN, {gap: 5});
		 * </listing>
		 */
		public static function joinChildsOf(container:DisplayObjectContainer, direction:String, vars:Object = null):Join {

			var j:Join = new Join(direction, container.getChildAt(0) as DisplayObject, vars);

			var l:uint = container.numChildren;
			for (var i:uint = 0; i < l; i++) {
				j.add(container.getChildAt(i));
			}

			var success:Boolean = j.__joinObject();
			j.onJoin.dispatch(j);

			return (success) ? j : null;
		}



		// PROPERTIES

		public function set refObj(value:DisplayObject):void {
			_refObj = value;
			objects[0] = _refObj;
		}

		public function get refObj():DisplayObject {
			return _refObj;
		}

		/**
		 * <p>Un <code>Array</code> que contiene los objetos que se unir&aacute;n.</p>
		 * @default Array
		 */
		public function get objects():Array {
			return _objects;
		}

		public function set objects(value:Array):void {
			_objects = value;
		}

		public function removeAll():void{
			objects = [];
		}

		/**
		 * <p>El espacio entre objeto y objeto despu&eacute;s de la uni&oacute;n.</p>
		 * @default 0
		 */
		public function set gap(value:uint):void {
			_gap = value;
		}

		public function get gap():uint {
			return _gap;
		}

		/**
		 * <p>Si se especifica, no se tiene en cuenta el ancho de los objetos en la uni&oacute;n sino una medida fija para todos.</p>
		 * @default NaN
		 */
		public function set fixedSize(value:Number):void {
			_fixedSize = Math.max(0, value);
		}

		public function get fixedSize():Number {
			return _fixedSize;
		}

		/**
		 * <p>Si es <code>true</code> indica que adem&aacute;s de la uni&oacute;n se realizar&aacute; una alineaci&oacute;n de objetos.</p>
		 * @default true
		 */
		public function set autoAlign(value:Boolean):void {
			_autoAlign = value;
		}

		public function get autoAlign():Boolean {
			return _autoAlign;
		}

		/**
		 * <p>La direcci&oacute;n hacia donde se realiza la uni&oacute;n</p>
		 * @param value Una String que define la direcci&oacute;n en la que se realizar&aacute; la uni&oacute;n
		 */
		public function set direction(value:String):void {
			_direction = value;
		}

		/**
		 * <p>Devuelve la la direcci&oacute;n en la que se realiza la uni&oacute;n.</p>
		 * @return String
		 */
		public function get direction():String {
			return _direction;
		}

		private var _round:Boolean;

		public function set round(value:Boolean):void {
			_round = value;
		}

		public function get round():Boolean {
			return _round;
		}





		/**
		 * @private
		 * <p>Verifica si todos los objetos de la uni&oacute;n poseen el mismo <code>parent</code>.</p>
		 * @return true si todos los objetos pertenecen al mismo <code>parent</code>.
		 */
		private function __parentIsSame(objs:Array):Boolean {

			var l:uint = objs.length;

			var parent:DisplayObjectContainer = (objs[0] as DisplayObject).parent as DisplayObjectContainer;

			for (var i:uint = 1; i < l; i++) {
				var obj:DisplayObject = objs[1] as DisplayObject;
				if (obj.parent !== parent) {
					return false;
				}
			}

			return true;
		}

		/**
		 * @private
		 * <p>Realiza la uni&oacute;n.</p>
		 * @return true si la uni&oacute;n se ha ejecutado correctamente
		 */
		private function __joinObject():Boolean {

			if (objects.indexOf(refObj) === -1) {
				objects.unshift(refObj);
			}

			var areBrothers:Boolean = __parentIsSame(objects);

			if (!areBrothers) {
				return false;
			}

			_copyOfObjects = objects.concat();

			_isFixedSize = (isNaN(fixedSize) != true);

			switch(direction) {

				case TO_TOP:
					__joinToTop();
					break;
				case TO_BOTTOM:
					__joinToBottom();
					break;
				case TO_LEFT:
					__joinToLeft();
					break;
				case TO_RIGHT:
					__joinToRight();
					break;
				default:
					throw new Error("[Join] (" + direction + ") no es un tipo de unión conocida.");
					return false;
					break;
			}

			return true;
		}

		/**
		 * @private
		 * <p>Realiza la uni&oacute;n a la derecha.</p>
		 */
		private function __joinToRight():void {

			var next:DisplayObject = __next();
			var nextX:Number = next.x;
			var nextY:Number = next.y;

			while (next != null) {

				var width:Number = _isFixedSize ? fixedSize : next.width;

				next.x = ( round ) ? nextX >> 0 : nextX;
				nextX += width + gap;

				if (autoAlign) {
					next.y = ( round ) ? nextY >> 0 : nextY;
				}

				next = __next();
			}
		}

		/**
		 * @private
		 * <p>Devuelve el siguiente objeto de la uni&oacute;n.</p>
		 *
		 * @return DisplayObject
		 */
		private function __next():DisplayObject {
			return _copyOfObjects.shift() as DisplayObject;
		}

		/**
		 * @private
		 * <p>Realiza la uni&oacute;n a la izquierda.</p>
		 */
		private function __joinToLeft():void {

			var next:DisplayObject = __next();
			var nextX:Number = next.x + (_isFixedSize ? fixedSize : next.width);
			var nextY:Number = next.y;

			while (next != null) {

				var width:Number = _isFixedSize ? fixedSize : next.width;

				nextX -= width;
				next.x = ( round ) ? nextX >> 0 : nextX;
				nextX -= gap;

				if (autoAlign) {
					next.y = ( round ) ? nextY >> 0 : nextY;
				}

				next = __next();
			}
		}

		/**
		 * @private
		 * <p>Realiza la uni&oacute;n hacia abajo.</p>
		 */
		private function __joinToBottom():void {

			var next:DisplayObject = __next();
			var nextY:Number = next.y;
			var nextX:Number = next.x;

			while (next != null) {

				var height:Number = _isFixedSize ? fixedSize : next.height;

				next.y = ( round ) ? nextY >> 0 : nextY;
				nextY += height;
				nextY += gap;

				if (autoAlign) {
					next.x = ( round ) ? nextX >> 0 : nextX;
				}

				next = __next();
			}
		}

		/**
		 * @private
		 * <p>Realiza la uni&oacute;n hacia arriba.</p>
		 */
		private function __joinToTop():void {

			var next:DisplayObject = __next();
			var nextY:Number = next.y + (_isFixedSize ? fixedSize : next.height);
			var nextX:Number = next.x;

			while (next != null) {

				var height:Number = _isFixedSize ? fixedSize : next.height;

				nextY -= height;
				next.y = ( round ) ? nextY >> 0 : nextY;
				nextY -= gap;

				if (autoAlign) {
					next.x = ( round ) ? nextX >> 0 : nextX;
				}

				next = __next();
			}
		}
	}
}