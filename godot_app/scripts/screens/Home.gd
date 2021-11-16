extends Control

onready var btn = $Button
onready var progress_bar = $ProgressBar


func _ready():
	connect("visibility_changed", self, "_on_home_btn_pressed")


func _on_home_btn_pressed() -> void:
	if not visible or not ServerConnection.enable_server_communication:
		return
	
	var rpc_id = "get_dungeon_progress"
	var result : NakamaAPI.ApiRpc = yield(ServerConnection._client.rpc_async(ServerConnection._session, rpc_id, JSON.print({"key":"water"})), "completed")
	if result.is_exception() or not result.payload:
		return
	
	var dungeon_progress:Models.DungeonProgress = Models.create_model_from_dict(Models.DungeonProgress.new(), parse_json(result.payload)[0])
	progress_bar.value = dungeon_progress.progress
