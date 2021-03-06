extends Node

const KEY := "test_key"

var _session : NakamaSession

var _client := Nakama.create_client(KEY)

var _socket:NakamaSocket


func write_data_async(table_name:String, data:Dictionary) -> void:
	yield(_client.write_storage_objects_async(
		_session,
		[
			NakamaWriteStorageObject.new(
				"game_data",
				table_name,
				DbInfo.READ_PREMISSIONS.PUBLIC_READ,
				DbInfo.WRITE_PREMISSIONS.OWNER_WRITE,
				JSON.print(data),
				""
			)
		]), "completed")


func get_data_async() -> Array:
	var data := {}
	
	var storage_object:NakamaAPI.ApiStorageObjects = yield(_client.read_storage_objects_async(_session, [NakamaStorageObjectId.new("some_data", "data", _session.user_id)]), "completed")
	
	if storage_object.objects:
		var decoded:Dictionary = JSON.parse(storage_object.objects[0].value).result
		data = decoded
	
	return data


func connect_to_server_async() -> int:
	_socket = Nakama.create_socket_from(_client)
	var result:NakamaAsyncResult = yield(_socket.connect_async(_session), "completed")
	
	if not result.is_exception():
		_socket.connect("closed", self, "_on_nakama_socket_closed")
		return OK
	
	return ERR_CANT_CONNECT


func authenticate_async(email:String, pwd:String) -> NakamaException:
	var err = null
	
	var new_session:NakamaSession = yield(_client.authenticate_email_async(email, pwd, "DBAdmin", true), "completed")
	
	if not new_session.is_exception():
		_session = new_session
	else:
		err = new_session.get_exception()
	
	return err


func _on_nakama_socket_closed() -> void:
	_socket = null
