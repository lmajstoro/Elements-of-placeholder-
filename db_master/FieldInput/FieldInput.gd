extends VBoxContainer

signal edit_changed

onready var lbl := $Label
onready var line_edit :LineEdit = $LineEdit
onready var option_btn:OptionButton = $OptionButton


func _ready():
	line_edit.connect("text_changed", self, "_on_text_changed")
	option_btn.connect("item_selected", self, "_on_item_selected")


func _on_text_changed(text) -> void:
	emit_signal("edit_changed", text)


func _on_item_selected(idx:int) -> void:
	if option_btn.get_item_text(idx) == "True":
		emit_signal("edit_changed", true)
	else:
		emit_signal("edit_changed", false)


func set_field(field_name:String, field_type:String) -> void:
	if field_type == "BOOLEAN":
		line_edit.hide()
		option_btn.show()
	
	lbl.text = "%s (%s)" % [field_name, field_type]
