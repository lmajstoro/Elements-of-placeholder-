extends Node

#Simulate requests and responses by hardcoding responses


func _ready():
	pass

#ili mozemo svaki floor dat slat s dungenom ko array dictionarya
#malo sam ljen popunjavat za vise floorova sve, kad dode backend cemo nadodat,m treba jos vidjet kak ce request tocno izgledat
func get_floor_data(request:Dictionary) -> Dictionary:
	return {
		"rewards" : {
			"gem":"neki gem",
			"shards" : "shardovi"#moramo smislit kako cemo neki range 1 - 5 slat od backenda
		},
		"time" : 3600,
		"current_time" : 0,
		"monsters":[],
		"runs" : 0,
		"floor" : 5
	}


func get_all_dungeons() -> Array:
	var dungeons:Array = []
	
	dungeons.append({
		"type" : "fire",
		"name" : "To hell and back",
		"max_floor" : 50,
		"unlocked" : true,
		"current_floor" : 30
	})
	
	dungeons.append({
		"type" : "water",
		"name" : "Beach party",
		"max_floor" : 30,
		"unlocked" : true,
		"current_floor" : 0
	})
	
	dungeons.append({
		"type" : "chaos",
		"name" : "Women",
		"max_floor" : 100,
		"unlocked" : false,
		"current_floor" : 0
	})
	
	return dungeons
