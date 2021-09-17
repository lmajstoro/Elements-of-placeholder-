extends VBoxContainer

onready var lbl := $Label
onready var line_edit := $LineEdit


func set_field(field_name:String, field_type:String) -> void:
	lbl.text = "%s (%s)" % [field_name, field_type]
