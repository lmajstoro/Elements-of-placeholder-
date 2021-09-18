extends Node2D

onready var FieldInputScene = preload("res://FieldInput/FieldInput.tscn")
onready var debug_panel = $Control/DebugPanel
onready var container = $Control/VBoxContainer2/Container
onready var add_model = $Control/VBoxContainer2/AddRecord
onready var table_names = $Control/VBoxContainer/TableNames
onready var show_records = $Control/VBoxContainer/ShowRecords
onready var add_new_record = $Control/VBoxContainer/AddNewRecord
onready var add_new_model_vbox = $Control/VBoxContainer2
onready var current_model_json:Label = $Control/VBoxContainer2/CurrentModelJson

var current_table:String
var current_model:Models.Model


func _ready():
	yield(authenticate_user(), "completed")
	yield(connect_to_server(), "completed")
	
	_fill_table_names()
	
	show_records.connect("pressed", self, "_on_show_records_pressed")
	add_new_record.connect("pressed", self, "_on_add_new_record_pressed")
	add_model.connect("pressed", self, "_on_add_model_pressed")
	
	#var data = yield(ServerConnection.get_data_async(), "completed")
	#debug_panel.write_msg(JSON.print(data))


func _on_show_records_pressed() -> void:
	pass


func _on_add_new_record_pressed() -> void:
	for c in container.get_children():
		c.free()
	
	add_new_model_vbox.show()
	_generate_field_inputs_for_table(table_names.get_item_text(table_names.selected))


func _on_add_model_pressed() -> void:
	yield(ServerConnection.write_data_async(current_table, current_model.get_json_model()), "completed")


func _fill_table_names() -> void:
	for table in DbInfo.tables:
		table_names.add_item(table)


func _generate_field_inputs_for_table(table_name:String) -> void:
	var model = Models.get_model_from_class_name(table_name)
	
	if not model:
		return
	
	current_table = table_name
	current_model = model
	
	var properties = model.get_property_list()
	
	for i in range(3, properties.size()):
		var field_input = FieldInputScene.instance()
		container.add_child(field_input)
		field_input.set_field(properties[i].name, _get_var_type_from_enum(properties[i].type))
		field_input.connect("edit_changed", self, "_on_field_edited", [model, properties[i].name])


func _on_field_edited(value, model, field_name:String) -> void:
	model.set(field_name, value)
	current_model_json.text = JSON.print(model.get_json_model(), "\n")


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
