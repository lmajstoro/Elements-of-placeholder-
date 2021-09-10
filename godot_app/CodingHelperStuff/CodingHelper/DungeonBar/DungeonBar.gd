extends Control

signal pressed

onready var dungeon_name = get_node("ColorRect/Name")
onready var max_floor = get_node("ColorRect/MaxFloor")
onready var element = get_node("ColorRect/Element")
onready var background = get_node("ColorRect")

var unlocked := false
var _data:Dictionary

func create_from_data(data:Dictionary) -> void:
	if data.has("type"):
		element.text = data.type
	if data.has("max_floor"):
		max_floor.text = "Max Floor: %s" % [data.max_floor]
	if data.has("name"):
		dungeon_name.text = data.name
	if data.has("unlocked"):
		unlocked = data.unlocked
		if not data.unlocked:
			background.modulate.a = 0.5
	
	_data = data


func _gui_input(event):
	if Input.is_action_pressed("click"):
		emit_signal("pressed", _data)
