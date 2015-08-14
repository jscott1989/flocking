package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var MAX_DISTANCE = 50;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		for (i in 0...200) {
			add(new Bird(this, FlxRandom.intRanged(0, FlxG.width), FlxRandom.intRanged(0, FlxG.height), FlxRandom.intRanged(0, 360)));
		}
	}
	
	public function getNearby(bird:Bird){
		var birds = new Array<Bird>();
		for (member in members) {
			var b:Bird = cast member;
			if (b == bird) {
				continue;
			}

            var XX = bird.x - b.x;
            var YY = bird.y - b.y;
            var distance = Math.sqrt( XX * XX + YY * YY );

            if (distance < MAX_DISTANCE) {
            	birds.push(b);
            }
		}
		return birds;
	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}