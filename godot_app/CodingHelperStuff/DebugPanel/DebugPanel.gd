extends Panel

onready var MsgScene = preload("res://CodingHelperStuff/DebugPanel/DebugMsg.tscn")
onready var container = $VBoxContainer

func write_msg(msg:String) -> void:
	var lbl = MsgScene.instance()
	lbl.text = msg
	container.add_child(lbl)
