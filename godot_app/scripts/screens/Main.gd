extends Control
tool

export var enable_server_communication:bool=false setget set_enable_server_communication

func set_enable_server_communication(v) -> void:
	enable_server_communication = v
	ServerConnection.enable_server_communication = enable_server_communication
