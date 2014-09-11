package game;
import flixel.FlxG;

/**
 * ...
 * @author Masadow
 */
class Hand
{
	private var dominos : Array<Domino>;

	public function new() 
	{
		dominos = [];
	}

	public function takeDomino(d : Domino) : Void
	{
		dominos.push(d);
	}

	public function size()
	{
		return dominos.length;
	}
	
	public function draw()
	{
		var x = 50;
		for (domino in dominos)
		{
			domino.y = FlxG.height - 64;
			domino.x = x;
			x += 32;
			domino.draw();
		}
	}
	
	public function iterator() : Iterator<Domino>
	{
		return dominos.iterator();
	}

}