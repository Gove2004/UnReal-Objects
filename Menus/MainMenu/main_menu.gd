extends Node2D


@export var start_button : Button
@export var end_button : Button
@export var language_button : CheckButton


func _ready() -> void:
	start_button.pressed.connect(on_start_button_pressed)
	end_button.pressed.connect(on_end_button_pressed)
	language_button.pressed.connect(on_language_button_change)
	localiz_language()


func on_start_button_pressed() -> void:
	GameManager.play_sfx()
	get_tree().change_scene_to_file("res://Menus/LevelMenu/level_menu.tscn")


func on_end_button_pressed() -> void:
	get_tree().quit()


func on_language_button_change() -> void:
	GameManager.language = "简体中文" if language_button.button_pressed else "English"
	localiz_language()


func localiz_language() -> void:
	var language = GameManager.language
	start_button.text = "开始游戏" if language == "简体中文" else "Start Game"
	end_button.text = "退出游戏" if language == "简体中文" else "Exit Game"
	language_button.text = "语言" if language == "简体中文" else "Language"
