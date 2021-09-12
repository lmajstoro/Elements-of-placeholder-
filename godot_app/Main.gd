extends Node

onready var debug_panel := $CanvasLayer/DebugPanel

func _ready():
	var email := "test@email.com"
	var pwd := "password"
	
	debug_panel.write_msg("Authenticating user %s" % email)
	var err:NakamaException = yield(Server.authenticate_async(email, pwd), "completed")
	
	if not err:
		debug_panel.write_msg("Atuhenticated user %s successfully" % email)
	else:
		debug_panel.write_msg("Atuhenticate failed, reason: %s" % err.message)
