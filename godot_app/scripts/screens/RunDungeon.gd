extends Control

onready var run_dungeon_btn = $RunDungeonButton

func _ready():
	$BackButton.connect("pressed", self, "_on_back_button_pressed")
	run_dungeon_btn.connect("pressed", self, "_on_run_dungeon_btn_pressed")


func _on_back_button_pressed() -> void:
	get_tree().change_scene("res://screens/Main.tscn")


func _on_run_dungeon_btn_pressed() -> void:
	if not ServerConnection.enable_server_communication:
		return
	
	var rpc_id = "run_dungeon"
	var info : NakamaAPI.ApiRpc = yield(ServerConnection._client.rpc_async(ServerConnection._session, rpc_id, JSON.print({"key":"water"})), "completed")
	if info.is_exception():
		print("An error occured: %s" % info)
		return
	print("Retrieved info: %s" % [parse_json(info.payload)])
