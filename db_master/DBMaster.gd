extends Node2D

onready var FieldInputScene = preload("res://FieldInput/FieldInput.tscn")
onready var debug_panel = $Control/DebugPanel
onready var container = $Control/Container

func _ready():
	#yield(authenticate_user(), "completed")
	#yield(connect_to_server(), "completed")
	_generate_field_inputs_for_dungeon()
	#yield(ServerConnection.write_data_async({"test":"best"}), "completed")
	#var data = yield(ServerConnection.get_data_async(), "completed")
	#debug_panel.write_msg(JSON.print(data))


func _generate_field_inputs_for_dungeon() -> void:
	var dungeon = Models.Dungeon.new()
	var properties = dungeon.get_property_list()
	
	for i in range(3, properties.size()):
		var field_input = FieldInputScene.instance()
		container.add_child(field_input)
		field_input.set_field(properties[i].name, _get_var_type_from_enum(properties[i].type))
		print(properties[i].name + ", type: " + str(properties[i].type))


func _get_var_type_from_enum(enum_type:int) -> String:
	var type:String = ""
	
	match enum_type:
		TYPE_INT:
			type = "INT"
		TYPE_STRING:
			type = "STRING"
		TYPE_BOOL:
			type = "BOOLEAN"
		TYPE_ARRAY:
			type = "ARRAY"
	
	return type


func connect_to_server() -> void:
	var result:int = yield(ServerConnection.connect_to_server_async(), "completed")
	if result == OK:
		debug_panel.write_msg("Connected to server")
	else:
		debug_panel.write_msg("Could not connect to server")


func authenticate_user() -> void:
	var email := "admin@email.com"
	var pwd := "super_secret_password_50316759"
	
	debug_panel.write_msg("Authenticating user %s" % email)
	var err:NakamaException = yield(ServerConnection.authenticate_async(email, pwd), "completed")
	
	if not err:
		debug_panel.write_msg("Autthenticated user %s successfully" % email)
	else:
		debug_panel.write_msg("Authenticate failed, reason: %s" % err.message)
