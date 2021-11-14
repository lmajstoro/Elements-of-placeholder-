extends Control
tool

onready var gem_button = $HBoxContainer/GemButton
onready var character_button = $HBoxContainer/CharacterButton
onready var dungeon_button = $HBoxContainer/DungeonButton
onready var pet_button = $HBoxContainer/PetButton
onready var home_button = $HBoxContainer/HomeButton

signal character_btn_pressed
signal gem_btn_pressed
signal dungeon_btn_pressed


func _ready():
	gem_button.connect("pressed", self, "_on_gem_button_pressed")
	character_button.connect("pressed", self, "_on_character_button_pressed")
	dungeon_button.connect("pressed", self, "_on_dungeon_button_pressed")
	home_button.connect("pressed", self, "_on_home_button_pressed")
	pet_button.connect("pressed", self, "_on_pet_button_pressed")


func _on_gem_button_pressed() -> void:
	Events.emit_signal("gem_btn_pressed")


func _on_character_button_pressed() -> void:
	Events.emit_signal("character_btn_pressed")


func _on_dungeon_button_pressed() -> void:
	Events.emit_signal("dungeon_btn_pressed")


func _on_pet_button_pressed() -> void:
	Events.emit_signal("pet_btn_pressed")


func _on_home_button_pressed() -> void:
	Events.emit_signal("home_btn_pressed")
