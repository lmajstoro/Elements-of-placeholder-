extends Control
tool

export var text_above:String setget set_above_text
export var texture:Texture setget set_dungeon_texture

signal pressed


func _ready():
	$Panel/TextureButton.connect("pressed", self, "emit_signal", ["pressed"])


func set_above_text(new_text:String) -> void:
	if not $Label:
		return
	
	text_above = new_text
	$Label.text = text_above


func set_dungeon_texture(new_tex:Texture) -> void:
	if not $Panel/TextureButton:
		return
	
	texture = new_tex
	$Panel/TextureButton.texture_normal = texture
