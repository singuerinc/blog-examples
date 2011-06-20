package net.singuerinc.labs.utils.display {

	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * <p><em>Alignment is the adjustment of an object in relation with other objects, or a
	 * static orientation of some object or set of objects in relation to others.</em></p>
	 *
	 * @author nahuel.scotti
	 */
	public class Align {

		/**
		 * <p>Es una se&ntilde;al que se emite cuando el <code>obj</obj> es alineado.</p>
		 */
		public var aligned:Signal;

		private var _obj:DisplayObject;

		/**
		 * <p>El objeto que queremos alinear.</p>
		 * @see #refObj
		 */
		public function set obj(value:DisplayObject):void {
			_obj = value;
			_objRectangle = _obj.getRect(_obj.parent);
		}

		public function get obj():DisplayObject {
			return _obj;
		}

		/**
		 * <p>El objeto que sirve como referencia para realizar la alineaci&oacute;n.</p>
		 * @see #obj
		 */
		public var refObj:DisplayObject;


		/**
		 * <p>El punto de origen antes de alinear un objeto.</p>
		 * @see #destination
		 */
		public var origin:Point;

		private var _destination:Point;

		/**
		 * <p>El punto de destino despu&eacute;s de alinear un objeto.</p>
		 * @see #origin
		 */
		public function get destination():Point {
			return _destination;
		}

		/**
		 * <p>Si es <code>true</code> indica que el objeto se alinear&aacute; con la modalidad "join",
		 * esto es, por ejemplo, si alineamos un objeto a la izquierda de otro, este se alinear&aacute;
		 * pegado a la izquierda y no <em>dentro</em> a la izquierda como alinea en modalidad "normal".</p>
		 * @see #joinY
		 */
		public var joinX:Boolean;

		/**
		 * <p>Si es <code>true</code> indica que el objeto se alinear&aacute; con la modalidad "join",
		 * esto es, por ejemplo, si alineamos un objeto arriba de otro, este se alinear&aacute; pegado
		 * arriba y no <em>dentro</em> arriba como alinea en modalidad "normal".</p>
		 * @see #joinX
		 */
		public var joinY:Boolean;

		/**
		 * @default 0
		 */
		public static const CENTER:int = 0;

		// vertical alignments constants
		/**
		 * @default -1
		 */
		public static const TOP:int = -1;
		/**
		 * @default 1
		 */
		public static const BOTTOM:int = 1;

		// horizontal alignments constants
		/**
		 * @default 1
		 */
		public static const LEFT:int = -2;
		/**
		 * @default 1
		 */
		public static const RIGHT:int = 2;

		// none alignment
		/**
		 * @default -100
		 */
		public static const NONE:int = -100;

		/**
		 * <p>Define el tipo de alineaci&oacute;n vertical que se realizar&aacute;.</p>
		 *
		 * @default Align.NONE
		 */
		public var vAlign:int = NONE;

		/**
		 * <p>Define el tipo de alineaci&oacute;n horizontal que se realizar&aacute;.</p>
		 *
		 * @default Align.NONE
		 */
		public var hAlign:int = NONE;

		/**
		 * <p>Si es <code>true</code> indica que la alineaci&oacute;n se realizar&aacute; al pixel.</p>
		 *
		 * @default true
		 */
		public var round:Boolean = true;

		/**
		 * <p>Indica la cantidad de pixeles que se mover&aacute; una imagen en horizontal,
		 * despu&eacute;s de la alineaci&oacute;n.</p>
		 *
		 * @default 0
		 * @see #offsetY
		 */
		public var offsetX:Number;

		/**
		 * <p>Indica la cantidad de pixeles que se mover&aacute; una imagen en vertical,
		 * despu&eacute;s de la alineaci&oacute;n.</p>
		 *
		 * @default 0
		 * @see #offsetX
		 */
		public var offsetY:Number;

		/**
		 * <p>Define el l&iacute;mite horizontal y m&iacute;nimo que puede tener un objeto
		 * en su propiedad x luego de realizar una alineaci&oacute;.</p>
		 *
		 * @default NaN
		 * @see #xMax
		 * @see #yMin
		 * @see #yMax
		 */
		public var xMin:Number;

		/**
		 * <p>Define el l&iacute;mite horizontal y m&aacute;ximo que puede tener un objeto en
		 * su propiedad x luego de realizar una alineaci&oacute;.</p>
		 *
		 * @default NaN
		 * @see #xMin
		 * @see #yMin
		 * @see #yMax
		 */
		public var xMax:Number;

		/**
		 * <p>Define el l&iacute;mite vertical y m&iacute;nimo que puede tener un objeto
		 * en su propiedad y luego de realizar una alineaci&oacute;.</p>
		 *
		 * @default NaN
		 * @see #xMin
		 * @see #xMax
		 * @see #yMax
		 */
		public var yMin:Number;

		/**
		 * <p>Define el l&iacute;mite verical y m&aacute;ximo que puede tener un objeto
		 * en su propiedad y luego de realizar una alineaci&oacute;.</p>
		 *
		 * @default NaN
		 * @see #xMin
		 * @see #xMax
		 * @see #yMin
		 */
		public var yMax:Number;

		/**
		 * <p>Indica si las propriedades <code>xMin</code>, <code>xMax</code>, <code>yMin</code>,
		 * <code>xMax</code> son relativas <code>refObj</code> o absolutas a su <code>parent</code>.</p>
		 *
		 * @default false
		 * @see #xMin
		 * @see #xMax
		 * @see #yMin
		 * @see #yMax
		 */
		public var relativeBounds:Boolean;

		/**
		 * <p>Si se define, indica el tama&ntilde;o que posee el objeto que se quiere alinear.</p>
		 * <p>Es especialmente &uacute;til cuando tenemos un objeto con una m&aacute;scara y no
		 * se puede calcular correctamente cuanto mide ese objeto.</p>
		 *
		 * @default NaN
		 * @see #objFixedHeight
		 * @see #refObjFixedWidth
		 * @see #refObjFixedHeight
		 */
		public function set objFixedWidth(value:Number):void {
			_objRectangle.width = value;
		}

		public function get objFixedWidth():Number {
			return _objRectangle.width;
		}

		/**
		 * <p>Si se define, indica el tama&ntilde;o que posee el objeto que se quiere alinear.</p>
		 * <p>Es especialmente &uacute;til cuando tenemos un objeto con una m&aacute;scara y no se
		 * puede calcular correctamente cuanto mide ese objeto.</p>
		 * @default NaN
		 * @see #objFixedWidth
		 * @see #refObjFixedWidth
		 * @see #refObjFixedHeight
		 */
		public function set objFixedHeight(value:Number):void {
			_objRectangle.height = value;
		}

		public function get objFixedHeight():Number {
			return _objRectangle.height;
		}

		/**
		 * <p>Si se define, indica el tama&ntilde;o que posee el objeto que sirve de referencia
		 * para la alineaci&oacute;.</p>
		 * <p>Es especialmente &uacute;til cuando tenemos un objeto con una m&aacute;scara y
		 * no se puede calcular correctamente cuanto mide ese objeto.</p>
		 *
		 * @default NaN
		 * @see #objFixedWidth
		 * @see #objFixedHeight
		 * @see #refObjFixedHeight
		 */
		public function set refObjFixedWidth(value:Number):void {
			_refObjRectangle.width = value;
		}

		public function get refObjFixedWidth():Number {
			return _refObjRectangle.width;
		}

		/**
		 * <p>Si se define, indica el tama&ntilde;o que posee el objeto que sirve de referencia para la alineaci&oacute;.</p>
		 * <p>Es especialmente &uacute;til cuando tenemos un objeto con una m&aacute;scara y no se puede calcular correctamente cuanto mide ese objeto.</p>
		 * @default NaN
		 * @see #objFixedWidth
		 * @see #objFixedHeight
		 * @see #refObjFixedWidth
		 */
		public function set refObjFixedHeight(value:Number):void {
			_refObjRectangle.height = value;
		}

		public function get refObjFixedHeight():Number {
			return _refObjRectangle.height;
		}

		/**
		 * <p>Indica si el objeto se alinear&aacute; autom&aacute;ticamente cuando el <code>Stage</code> dispare un evento de tipo <code>Event.RESIZE</code>.</p>
		 *
		 * @default false
		 */
		public function set snap(value:Boolean):void {
			_snap = value;

			// init stage & stage resize listener
			if (!__snapListener && obj.stage != null) {
				__stage = obj.stage;
				__stage.addEventListener(Event.RESIZE, __onStageResize);
				__snapListener = true;
			}

			if (_snap && refObj is Stage) {
				__snapObjectDictionary[obj] = this;
			} else if (_snap && (refObj is Stage) == false) {
				// TODO: Test this
				throw new Error("[Align] No se puede realizar 'snap' en un objeto de referencia que no sea de tipo Stage.");
			} else {
				delete __snapObjectDictionary[obj];
			}
		}

		public function get snap():Boolean {
			return _snap;
		}


		private var __stage:Stage;
		private var _vars:Object;
		private var _snap:Boolean;

		/**
		 * <p>Constructor</p>
		 *
		 * @param refObj Es el objeto que sirve como referencia, un <code>DisplayObject</code> o <code>Rectangle</code>.
		 * @param obj Es el objeto que se quiere alinear
		 * @param vars
		 *
		 * @see #Align.to()
		 *
		 */
		public function Align(refObj:*, obj:DisplayObject, vars:Object = null) {

			aligned = new Signal(Align);

			this.obj = obj;
			this.refObj = (refObj is DisplayObject) ? refObj : null;
			_vars = (vars == null) ? {} : vars;

			// alignment type
			this.vAlign = (_vars.vAlign != undefined) ? _vars.vAlign : NONE;
			this.hAlign = (_vars.hAlign != undefined) ? _vars.hAlign : NONE;

			// join's style
			this.joinX = (_vars.joinX != undefined) ? _vars.joinX : false;
			this.joinY = (_vars.joinY != undefined) ? _vars.joinY : false;

			// round destination
			this.round = (_vars.round != undefined) ? _vars.round : false;

			// snap to stage
			this.snap = (_vars.snap != undefined) ? _vars.snap : false;

			// offset
			this.offsetX = (_vars.offsetX != undefined) ? _vars.offsetX : 0;
			this.offsetY = (_vars.offsetY != undefined) ? _vars.offsetY : 0;

			// relative bounds
			this.relativeBounds = (_vars.relativeBounds != undefined) ? _vars.relativeBounds : false;

			// Si el objeto referencia es de tipo Stage, no podemos tomar como referencia
			// el width y el height, porque dan valores erroneos, los sustituimos con stageWidth y stageHeight
			if (refObj is Stage) {
				var stage:Stage = refObj as Stage;
				_refObjRectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			} else if (refObj is DisplayObject) {
				_refObjRectangle = refObj.getBounds(refObj.parent);
				// TODO: Test, no entiendo por qué no funciona cuando es parent
				// _refObjRectangle = refObj.getBounds(refObj);
			} else if (refObj is Rectangle) {
				_refObjRectangle = refObj;
			}

			// fixed object width & height
			this.objFixedWidth = (_vars.objFixedWidth != undefined) ? _vars.objFixedWidth : _objRectangle.width;
			this.objFixedHeight = (_vars.objFixedHeight != undefined) ? _vars.objFixedHeight : _objRectangle.height;

			_objRectangle.width = objFixedWidth;
			_objRectangle.height = objFixedHeight;

			// fixed refObject width & height
			this.refObjFixedWidth = (_vars.refObjFixedWidth != undefined) ? _vars.refObjFixedWidth : _refObjRectangle.width;
			this.refObjFixedHeight = (_vars.refObjFixedHeight != undefined) ? _vars.refObjFixedHeight : _refObjRectangle.height;

			_refObjRectangle.width = refObjFixedWidth;
			_refObjRectangle.height = refObjFixedHeight;

			// mins & maxs destinations
			this.xMin = _vars.xMin + (relativeBounds ? _refObjRectangle.x : 0);
			this.xMax = _vars.xMax + (relativeBounds ? _refObjRectangle.x : 0);
			this.yMin = _vars.yMin - (relativeBounds ? _refObjRectangle.y : 0);
			this.yMax = _vars.yMax - (relativeBounds ? _refObjRectangle.y : 0);
		}

		private static var __snapObjectDictionary:Dictionary = new Dictionary();
		private static var __snapListener:Boolean;

		/**
		 * // TODO: Falta descripción
		 *
		 * @example
		 * <listing version="3.0">
		 * Align.to(refObj, obj, {hAlign: Align.CENTER, vAlign: Align.BOTTOM});
		 * // or...
		 * Align.to(stage, obj, {hAlign: Align.RIGHT, vAlign: Align.MIDDLE, offsetX: 20, joinX: true});
		 * // or...
		 * Align.to(refObj, obj, {hAlign: Align.LEFT, offsetY: 130, yMax: 420});
		 * </listing>
		 *
		 * @see Align()
		 */
		public static function to(refObj:DisplayObject, obj:DisplayObject, vars:Object = null):Align {

			var align:Align = new Align(refObj, obj, vars);
			align.align();
			return align;
		}

		// public static function groupTo(refObj:DisplayObject, objs:Array, vars:Object = null):Align {
		//
		// var obj:DisplayObject = objs.shift() as DisplayObject;
		// var align:Align = new Align(refObj, obj, vars);
		// align.align();
		//
		// var distX:Number = Point.distance(new Point(align.origin.x, 0), new Point(align.destination.x, 0));
		// var distY:Number = Point.distance(new Point(0, align.origin.y), new Point(0, align.destination.y));
		//
		// var l:uint = objs.length;
		// for(var i:uint=0; i<l; i++){
		// var _o:DisplayObject = objs[i] as DisplayObject;
		// _o.x += distX;
		// _o.y += distY;
		// }
		//
		// return align;
		// }

		public static function inContainer(obj:DisplayObject, vars:Object = null):Align {
			var container:DisplayObjectContainer = obj.parent;
			var rect:Rectangle = container.getBounds(container);
			return toRect(rect, obj, vars);
		}

		/**
		 * <p>Alinea un objeto en relaci&oacute;n a un <code>Rectangle</code>.</p>
		 *
		 * @example
		 * <listing version="3.0">
		 * var rect:Rectangle = new Rectangle(100, 150, 250, 120);
		 * Align.toRect(rect, obj, {hAlign: Align.CENTER, vAlign: Align.BOTTOM});
		 * </listing>
		 *
		 * @see #to()
		 */
		public static function toRect(rect:Rectangle, obj:DisplayObject, vars:Object = null):Align {
			var align:Align = new Align(rect, obj, vars);
			align.align();
			return align;
		}


		/**
		 * <p>Simula una alineaci&oacute;n y devuelve el resultado en un objeto <code>Align</code> sin modificar la posici&oacute;n del objeto real.</p>
		 *
		 * @example
		 * <listing version="3.0">
		 * var obj:Sprite = new Sprite();
		 * obj.x = 200;
		 * obj.y = 300;
		 *
		 * var result:Align = Align.getDestination(stage, obj, {hAlign: Align.CENTER, vAlign: Align.TOP});
		 *
		 * trace(result.destination.x); // 500
		 * trace(result.destination.y); // 432
		 *
		 * trace(obj.x); // 200
		 * trace(obj.y); // 300
		 *
		 * </listing>
		 * @see #to()
		 */
		public static function getDestination(refObj:*, obj:DisplayObject, vars:Object = null):Align {
			var align:Align = new Align(refObj, obj, vars);
			align.__basicInternalAlign();
			return align;
		}

		public function align():Align {
			__basicInternalAlign();
			__applyAlign();
			aligned.dispatch(this);
			return this;
		}

		private function __applyAlign():void {

			obj.x = destination.x;
			obj.y = destination.y;

		}

		// Un rectangulo que representa el area del objeto a alinear
		private var _objRectangle:Rectangle;
		// Un rectangulo que representa el area del objeto de referencia
		private var _refObjRectangle:Rectangle;

		// // // // //     INTERNAL

		/**
		 * @private
		 * <p>Es la función que se encarga de la alineci&ooacute;n
		 * b&aacute;sica, principalmente, alinea un objeto en
		 * horizontal y vertical seg&uacute;n los parametros de <code>vars</code>.</p>
		 */
		private function __basicInternalAlign():Point {

			origin = new Point(obj.x, obj.y);
			_destination = origin;

			// Alineamos en vertical
			if (vAlign == TOP) {
				// Comprobamos el m&eacute;todo de alineaci&oacute;n, join o normal
				if (joinY) {
					destination.y = _refObjRectangle.top - _objRectangle.height;
				} else {
					destination.y = _refObjRectangle.top;
				}
			} else if (vAlign == CENTER) {
				destination.y = ( _refObjRectangle.top + ( _refObjRectangle.height / 2 ) ) - ( _objRectangle.height / 2 );
			} else if (vAlign == BOTTOM) {
				if (joinY) {
					destination.y = _refObjRectangle.bottom;
				} else {
					destination.y = _refObjRectangle.bottom - _objRectangle.height;
				}
			}

			// Alineamos en horizontal
			if (hAlign == LEFT) {
				if (joinX) {
					destination.x = _refObjRectangle.left - _objRectangle.width;
				} else {
					destination.x = _refObjRectangle.left;
				}
			} else if (hAlign == CENTER) {
				destination.x = ( _refObjRectangle.left + ( _refObjRectangle.width / 2) ) - ( _objRectangle.width / 2 );
			} else if (hAlign == RIGHT) {
				if (joinX) {
					destination.x = _refObjRectangle.right;
				} else {
					destination.x = _refObjRectangle.right - _objRectangle.width;
				}
			}

			__setOffset();

			__setMinAndMax();

			__setRound();

			return destination;
		}

		/**
		 * @private
		 */
		private function __onStageResize(event:Event):void {

			for (var i : Object in __snapObjectDictionary) {

				var __align:Align = __snapObjectDictionary[i];
				__align._refObjRectangle.width = __stage.stageWidth;
				__align._refObjRectangle.height = __stage.stageHeight;
				__align.align();
			}
		}

		/**
		 * @private
		 */
		private function __setRound():void {

			if (round) {
				destination.x = Math.round(destination.x);
				destination.y = Math.round(destination.y);
			}
		}

		/**
		 * @private
		 */
		private function __setMinAndMax():void {

			if (!isNaN(xMin)) {
				destination.x = Math.max(xMin, destination.x);
			}

			if (!isNaN(xMax)) {
				destination.x = Math.min(xMax, destination.x);
			}

			if (!isNaN(yMin)) {
				destination.y = Math.max(yMin, destination.y);
			}

			if (!isNaN(yMax)) {
				destination.y = Math.min(yMax, destination.y);
			}
		}

		/**
		 * @private
		 * <p>Recoge los datos de offset y los
		 * aplica al objeto alineado.</p>
		 */
		private function __setOffset():void {

			destination.x += offsetX;
			destination.y += offsetY;
		}
	}
}