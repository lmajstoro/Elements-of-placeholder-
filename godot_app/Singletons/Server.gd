extends Node

const KEY:= "test_key"

var _session: NakamaSession

var _client := Nakama.create_client(KEY)

func _ready():
	pass


func authenticate_async(email:String, pwd:String):
	var err = null
	
	var new_session:NakamaSession = yield(_client.authenticate_email_async(email, pwd, "Cofi", true), "completed")
	
	if not new_session.is_exception():
		_session = new_session
	else:
		err = new_session.get_exception()
	
	return err
