package ;

import flixel.FlxG;

/**
 * ...
 * @author Masadow
 */
class Player
{
	
	public static var logged = null;

	//Asynchronous call
	public static function login(result : Dynamic, done : Void -> Void)
	{
		for (r in cast(result, List<Dynamic>))
			FlxG.log.add(r);
		done();
	}

	public function new() 
	{
		
	}
	
}