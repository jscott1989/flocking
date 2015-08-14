import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxVector;

class Bird extends FlxSprite {

    public var travelSpeed:Int = 100;
    private var playstate:PlayState;

    public function new(playstate:PlayState, x:Int, y:Int, angle:Int) {
        super(x, y);
        makeGraphic(2, 2, FlxColor.GREEN);
        // loadGraphic(AssetPaths.bird__png);
        // this.angle = angle;
        velocity.x = Math.cos((Math.PI/180) * (angle - 90)) * travelSpeed;
        velocity.y = Math.sin((Math.PI/180) * (angle - 90)) * travelSpeed;
        this.playstate = playstate;
    }

    public function updateAngle(){
        var closeBirds = playstate.getNearby(this);

        var v1 = new FlxVector(0, 0);
        for(bird in closeBirds) {
            v1.x += bird.velocity.x;
            v1.y += bird.velocity.y;
        }

        if (closeBirds.length > 0) {
            v1.x /= closeBirds.length;
            v1.y /= closeBirds.length;
            v1.normalize();
        }

        var v2 =  new FlxVector(0,0);

        for(bird in closeBirds) {
            v2.x += bird.x;
            v2.y += bird.y;
        }
        if (closeBirds.length > 0) {
            v2.x /= closeBirds.length;
            v2.y /= closeBirds.length;
            v2.x -= x;
            v2.y -= y;
            v2.normalize();
        }

        var v3 =  new FlxVector(0,0);

        for(bird in closeBirds) {
            v3.x += bird.x - x;
            v3.y += bird.y - y;
        }
        if (closeBirds.length > 0) {
            v3.x /= closeBirds.length;
            v3.y /= closeBirds.length;
            v3.x *= -1;
            v3.y *= -1;
            v3.normalize();
        }

        var vfinal = new FlxVector(velocity.x + v1.x + v2.x + v3.x, velocity.y + v1.y + v2.y + v3.y);
        vfinal.normalize();

        velocity.x = vfinal.x * travelSpeed;
        velocity.y = vfinal.y * travelSpeed;
    }

    public override function update() {
        updateAngle();

        if (0 >= x) {
            velocity.x = Math.abs(velocity.x);
        }else if (x >= FlxG.width-width){
            velocity.x = Math.abs(velocity.x) * -1;
        }

        if (0 >= y) {
            velocity.y = Math.abs(velocity.y);
        } else if (y >= FlxG.height-height){
            velocity.y = Math.abs(velocity.y) * -1;
        }
        super.update();
    }
}