extends Node2D


@export var level_icon_array : Array[Control]


func _ready() -> void:
	for level in level_icon_array:
		level.on_button_press.connect(on_level_pressed)


func on_level_pressed() -> void:
	GameManager.play_sfx()
	get_tree().change_scene_to_file("res://Menus/GameMenu/game_menu.tscn")
