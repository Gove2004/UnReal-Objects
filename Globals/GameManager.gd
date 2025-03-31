extends Node


var language = "English"

var SIZE = 64


var level_index = 0
var level_data : Dictionary


var action_array : Array[Action]
@export var debug_action_array : Array[Action]


var player
var game_menu

@export var globalSFXbutton : AudioStreamPlayer



func _ready() -> void:
	level_data = load_data()


func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("debug"):
		#action_array = debug_action_array.duplicate()
		#game_menu.set_action_list()
		#game_menu.show_tip("DEBUG MODE", Color.SKY_BLUE, 1.0)
	#if Input.is_action_just_pressed("reset_data"):
		#level_data = {
			#"0": 999,
			#"1": 0,
			#"2": -1,
			#"3": -1,
			#"4": -1,
			#"5": 999
		#}
		#save_data()
		#load_data()
	if player != null and Input.is_action_just_pressed("uodo"):
		player.undo()


func add_new_action(action: Action) -> void:
	action_array.append(action)
	if game_menu != null:
		game_menu.set_action_list()


func get_action_in_array(index : int) -> Action:
	if index >= action_array.size():
		return null
	else:
		return action_array[index]


func clear_action_array() -> void:
	action_array.clear()


func add_commands_on_player(commands: Array[String]) -> void:
	if player == null: return
	for command in commands:
		player.add_command(command)
	player.execute_move()


func win(star: int) -> void:
	level_data[str(level_index)] = max(level_data[str(level_index)], star)
	level_data[str(level_index + 1)] = max(level_data[str(level_index + 1)], 0)
	save_data()
	
	get_tree().change_scene_to_file("res://Menus/LevelMenu/level_menu.tscn")


func lose() -> void:
	get_tree().change_scene_to_file("res://Menus/LevelMenu/level_menu.tscn")


func load_data() -> Dictionary:
	var data = {}
	var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
	if file:
		data = file.get_var()
		file.close()
		print("load_data = ")
		print(data)
		return data
	return {
		"0": 999,
		"1": 0,
		"2": -1,
		"3": -1,
		"4": -1,
		"5": 999
	}


func save_data() -> bool:
	var file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	if file:
		file.store_var(level_data)
		file.close()
		return true
	return false


func play_sfx() -> void:
	globalSFXbutton.play()
