package ;

import flixel.FlxG;

/**
 * ...
 * @author Masadow
 */
class Player
{
	public var name(default, null) : String;
	public var id(default, null) : String;

	public static var logged(default, null) : Player = null;

	//Asynchronous call
	public static function login(result : Dynamic, done : Void -> Void)
	{
		if (result != null)
			logged = new Player(result.id, result.name);
		done();
	}

	private function new(id : String, name : String)
	{
		this.id = id;
		this.name = name;
	}
	
}