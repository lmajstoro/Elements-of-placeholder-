extends Panel
tool

export var icon:Texture setget set_icon

signal pressed


func _ready():
	$TextureButton.connect("pressed", self, "emit_signal", ["pressed"])


func set_icon(new_icon:Texture) -> void:
	icon = new_icon
	$TextureButton.texture_normal = new_icon
