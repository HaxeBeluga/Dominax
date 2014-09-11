package net;

/**
 * ...
 * @author Masadow
 */
interface IServerApi
{
	public function login(id : Int) : { id : Int, name : String };
}