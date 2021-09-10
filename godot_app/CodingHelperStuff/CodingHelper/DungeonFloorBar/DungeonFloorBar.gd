extends Control

signal pressed

onready var floor_num = get_node("ColorRect/Floor")

var _data:Dictionary

func create_from_data(data:Dictionary) -> void:
	_data = data


func _gui_input(event):
	if Input.is_action_pressed("click"):
		emit_signal("pressed", _data)
