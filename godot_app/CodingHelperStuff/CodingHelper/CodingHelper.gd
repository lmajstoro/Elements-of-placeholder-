extends Node

#Scene used to make modular systems
#You can run only this scene by pressing F6
#If it works on a single scene independently from everything else in the project using dummy api and such
#Then it is good to be implemented into the existing project

############################
#Current modular system WIP: Dungeon System
############################

onready var floor_progress_vb = get_node("ColorRect/VBoxContainer")
onready var dungeon_bars = get_node("ColorRect/VBoxContainer2")
onready var floor_bars = get_node("ColorRect/ScrollContainer/VBoxContainer3")
onready var floor_bars_scroll = get_node("ColorRect/ScrollContainer") #rename
onready var current_floor_label = get_node("ColorRect/VBoxContainer/Label")
onready var progress_bar = get_node("ColorRect/VBoxContainer/ProgressBar")
onready var start_dungeon_floor_btn = get_node("ColorRect/VBoxContainer/Button")

onready var DungeonBarScene = preload("res://CodingHelperStuff/CodingHelper/DungeonBar/DungeonBar.tscn")
onready var DungeonFloorBarScene = preload("res://CodingHelperStuff/CodingHelper/DungeonFloorBar/DungeonFloorBar.tscn")

var selected_floor_data:Dictionary

func _ready():
	_add_dungeons()
	start_dungeon_floor_btn.connect("pressed", self, "_on_start_dungeon_floor_pressed")


func _add_dungeons() -> void:
	var dungeons = ApiSimulator.get_all_dungeons()
	
	for data in dungeons:
		var dungeon = DungeonBarScene.instance()
		dungeon_bars.add_child(dungeon)
		dungeon.create_from_data(data)
		if dungeon.unlocked:
			dungeon.connect("pressed", self, "_on_dungeon_bar_selected")


func _add_floors(data:Dictionary) -> void:
	for i in data.max_floor:
		i += 1
		var floor_data = ApiSimulator.get_floor_data({})
		var floor_bar = DungeonFloorBarScene.instance()
		floor_bars.add_child(floor_bar)
		floor_bar.create_from_data(floor_data)
		floor_bar.floor_num.text = "Floor: " + str(i)
		floor_bar.connect("pressed", self, "_on_dungeon_floor_bar_selected")


func _on_dungeon_bar_selected(data:Dictionary) -> void:
	_add_floors(data)


func _on_dungeon_floor_bar_selected(data:Dictionary) -> void:
	floor_bars_scroll.visible = false
	floor_progress_vb.visible = true
	current_floor_label.text = "Current Floor: %d" % data.floor
	selected_floor_data = data


func _on_start_dungeon_floor_pressed() -> void:
	progress_bar.max_value = selected_floor_data.time
	progress_bar.value = 1200
