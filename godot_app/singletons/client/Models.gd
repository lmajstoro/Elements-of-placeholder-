extends Node

class Model:
	pass

class DungeonProgress extends Model:
	var progress:float
	var finished:bool
	var duration:int
	var type:String


func create_model_from_dict(model:Model, dict:Dictionary) -> Model:
	for idx in range(3, model.get_property_list().size()):
		var prop = model.get_property_list()[idx]
		if prop.name in dict:
			model.set(prop.name, dict[prop.name])
	
	return model
