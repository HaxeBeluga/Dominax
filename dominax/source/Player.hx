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
	public static function login(done : Void -> Void)
	{
		//Request the server for the current logged player
		FlxG.log.add("login");
		done();
	}
	
	public function new() 
	{
		
	}
	
}