extends Control

onready var dungeon_screen = $Dungeons
onready var character_screen = $Character
onready var gem_screen = $Gem
onready var pet_screen = $Pet
onready var home_screen = $Home

enum SCREEN {
	Gem,
	Character,
	Dungeon,
	Pet,
	Home
}


func _ready():
	Events.connect("gem_btn_pressed", self, "_on_screen_bottom_bar_btn_pressed", [SCREEN.Gem])
	Events.connect("character_btn_pressed", self, "_on_screen_bottom_bar_btn_pressed", [SCREEN.Character])
	Events.connect("dungeon_btn_pressed", self, "_on_screen_bottom_bar_btn_pressed", [SCREEN.Dungeon])
	Events.connect("home_btn_pressed", self, "_on_screen_bottom_bar_btn_pressed", [SCREEN.Home])
	Events.connect("pet_btn_pressed", self, "_on_screen_bottom_bar_btn_pressed", [SCREEN.Pet])


func _on_screen_bottom_bar_btn_pressed(screen:int) -> void:
	_show_only_selected_screen(screen)


func _show_only_selected_screen(selected_screen_idx:int) -> void:
	var selected_screen:Control
	
	match selected_screen_idx:
		SCREEN.Gem:
			selected_screen = gem_screen
		SCREEN.Character:
			selected_screen = character_screen
		SCREEN.Dungeon:
			selected_screen = dungeon_screen
		SCREEN.Home:
			selected_screen = home_screen
		SCREEN.Pet:
			selected_screen = pet_screen
	
	if selected_screen:
		selected_screen.show()
	
	for screen in get_children():
		if screen == selected_screen:
			continue
		
		screen.hide()
