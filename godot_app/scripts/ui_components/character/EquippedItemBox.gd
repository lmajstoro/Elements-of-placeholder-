extends Node
tool

export var default_icon:Texture setget set_default_icon


func set_default_icon(new_tex:Texture) -> void:
	if not $Panel/TextureRect:
		return
	
	default_icon = new_tex
	$Panel/TextureRect.texture = default_icon
