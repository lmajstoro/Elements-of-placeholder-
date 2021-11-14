extends Node

onready var debug_panel := $CanvasLayer/DebugPanel

#func _ready():
#	yield(authenticate_user(), "completed")
#	yield(connect_to_server(), "completed")
#	yield(ServerConnection.write_data_async({"test":"best"}), "completed")
#	var data = yield(ServerConnection.get_data_async(), "completed")
#	debug_panel.write_msg(JSON.print(data))
#
#
#func connect_to_server() -> void:
#	var result:int = yield(ServerConnection.connect_to_server_async(), "completed")
#	if result == OK:
#		debug_panel.write_msg("Connected to server")
#	else:
#		debug_panel.write_msg("Could not connect to server")
#
#
#func authenticate_user() -> void:
#	var email := "test@email.com"
#	var pwd := "password"
#
#	debug_panel.write_msg("Authenticating user %s" % email)
#	var err:NakamaException = yield(ServerConnection.authenticate_async(email, pwd), "completed")
#
#	if not err:
#		debug_panel.write_msg("Atuhenticated user %s successfully" % email)
#	else:
#		debug_panel.write_msg("Atuhenticate failed, reason: %s" % err.message)
