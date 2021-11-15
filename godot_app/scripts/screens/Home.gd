extends Control

onready var btn = $Button
onready var progress_bar = $ProgressBar


func _ready():
	btn.connect("pressed", self , "_on_btn_pressed")


func _on_btn_pressed() -> void:
	var rpc_id = "get_dungeon_progress"
	var info : NakamaAPI.ApiRpc = yield(ServerConnection._client.rpc_async(ServerConnection._session, rpc_id, JSON.print({"key":"water"})), "completed")
	if info.is_exception():
		print("An error occured: %s" % info)
		return
	#lbl.text = str(parse_json(info.payload))
