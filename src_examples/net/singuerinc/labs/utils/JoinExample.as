package net.singuerinc.labs.utils {

	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import net.singuerinc.labs.utils.display.Join;

	[SWF(backgroundColor="#121212", frameRate="60", width="640", height="480")]
	public class JoinExample extends Sprite {

		public function JoinExample() {
			
			var pb1:PushButton = new PushButton(this, 0, 0, 'PB 1');
			var pb2:PushButton = new PushButton(this, 0, 0, 'PB 2');
			var pb3:PushButton = new PushButton(this, 0, 0, 'PB 3');
			var pb4:PushButton = new PushButton(this, 0, 0, 'PB 4');
			var pb5:PushButton = new PushButton(this, 0, 0, 'PB 5');
			
			//join pb1, pb2, pb3
			var j:Join = new Join(Join.TO_RIGHT, pb1);
			j.gap = 10;
			j.add(pb2);
			j.add(pb3);
			j.join();
			
			
			//join pb1, pb4, pb5
			j.removeAll();
			j.refObj = pb1;
			j.direction = Join.TO_BOTTOM;
			j.add(pb4);
			j.add(pb5);
			j.join();
			
			
		}
	}
}
