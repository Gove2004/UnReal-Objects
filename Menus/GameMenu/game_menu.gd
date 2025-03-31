extends Node2D


@export var action_list : HBoxContainer
@export var restart_button : Button
@export var exit_button : Button
@export var tip_panel : Panel
@export var tip_text : Label
@export var tip_audioplayer : AudioStreamPlayer


func _ready() -> void:
	GameManager.game_menu = self
	load_map()
	
	restart_button.pressed.connect(on_restart_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)
	
	set_action_list()
	
	localiz_language()


func set_action_list() -> void:
	var action_icon_array = action_list.get_children()
	for i in range(action_icon_array.size()):
		action_icon_array[i].set_action(GameManager.get_action_in_array(i))


func show_tip(str: String, color: Color, duration: float) -> void:
	tip_audioplayer.play()
	GameManager.player.able_move = false
	tip_panel.visible = true
	tip_text.text = str
	tip_text.add_theme_color_override("font_color", color)
	await get_tree().create_timer(duration).timeout
	tip_panel.visible = false
	GameManager.player.able_move = true


func on_restart_button_pressed() -> void:
	GameManager.play_sfx()
	get_tree().change_scene_to_file("res://Menus/GameMenu/game_menu.tscn")


func on_exit_button_pressed() -> void:
	GameManager.play_sfx()
	get_tree().change_scene_to_file("res://Menus/LevelMenu/level_menu.tscn")


func load_map() -> void:
	var index = GameManager.level_index
	var map
	if index == 1:
		map = load("res://Maps/1.tscn").instantiate()
	elif index == 2:
		map = load("res://Maps/2.tscn").instantiate()
	elif index == 3:
		map = load("res://Maps/3.tscn").instantiate()
	elif index == 4:
		map = load("res://Maps/4.tscn").instantiate()
	else:
		map = load("res://Maps/0.tscn").instantiate()
	add_child(map)
	GameManager.player.position = map.get_node("StartPos").position


func localiz_language() -> void:
	var language = GameManager.language
	restart_button.text = "重开" if language == "简体中文" else "Restart"
	exit_button.text = "退出" if language == "简体中文" else "Exit"
