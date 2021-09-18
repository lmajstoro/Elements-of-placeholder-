extends Node

class Model:
	func get_json_model() -> Dictionary:
		var properties = get_property_list()
		var data:Dictionary = {}
		for i in range(3, properties.size()):
			data[properties[i].name] = get(properties[i].name)
		return data

class Dungeon extends Model:
	var type:String
	var dungeon_name:String
	var max_floor:int
	var unlocked:bool
	var current_floor:int


class Item extends Model:
	var some_field:String


func get_model_from_class_name(class_name_string:String) -> Model:
	match class_name_string:
		DbInfo.tables.dungeon:
			return Dungeon.new()
		DbInfo.tables.item:
			return Item.new()
		
	return null
