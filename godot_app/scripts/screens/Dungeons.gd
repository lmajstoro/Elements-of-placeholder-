extends Control


func _ready():
	$VBoxContainer/WaterDungeon.connect("pressed", self, "_on_water_dungeon_pressed")


func _on_water_dungeon_pressed() -> void:
	get_tree().change_scene("res://screens/RunDungeon.tscn")
