package ;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Compiler;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Masadow
 */
class Assets
{
	private static function deepCopy(src : String, dest : String)
	{
		for (file in FileSystem.readDirectory(src))
		{
			if (file.charAt(0) == ".") //Ignore every hidden files
				continue ;
			var path = src + file;
			if (FileSystem.isDirectory(path))
			{
				var newdest = dest + file + "/";
				FileSystem.createDirectory(newdest);
				deepCopy(path + "/", newdest);
			}
			else
				File.copy(path, dest + file);
		}
	}
	
	private static function deepDelete(src : String)
	{
		for (file in FileSystem.readDirectory(src))
		{
			if (file.charAt(0) == ".")
				continue ;
			var path = src + "/" + file;
			if (FileSystem.isDirectory(path))
				deepDelete(path);
			else
				FileSystem.deleteFile(path);
		}
		FileSystem.deleteDirectory(src);
	}
	
	macro public static function build() : Expr
	{
		var dest = Compiler.getOutput();
		var src = "assets/";
		
		//Clean assets
		for (file in FileSystem.readDirectory(dest))
		{
			if (file.charAt(0) == "." || ["dominax", "lib", "res"].indexOf(file) >= 0)
				continue ;
			if (FileSystem.isDirectory(dest + "/" + file))
				deepDelete(dest + "/" + file);
		}

		//Copy new files
		deepCopy(src, dest + "/");

		return macro "Done";
	}
	
}