extends Control
tool

export var text:String setget set_text
export var text_size:int setget set_text_size

onready var progress_bar:ProgressBar = $VBoxContainer/ProgressBar

var value:float setget set_progress_bar_value


func set_text(new_text) -> void:
	if not $VBoxContainer/Label:
		return
	
	text = new_text
	$VBoxContainer/Label.text = text


func set_text_size(new_text_size) -> void:
	if not $VBoxContainer/Label:
		return
	
	text_size = new_text_size
	$VBoxContainer/Label.get_font("font").size = text_size


func set_progress_bar_value(new_value) -> void:
	progress_bar.value = new_value
