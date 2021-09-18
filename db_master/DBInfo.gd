extends Node


enum READ_PREMISSIONS {
	NO_READ
	OWNER_READ
	PUBLIC_READ
}

enum WRITE_PREMISSIONS {
	NO_WRITE
	OWNER_WRITE
}


var tables:Dictionary = {
	"dungeon" : "dungeon",
	"item" : "item"
}
