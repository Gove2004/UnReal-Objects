extends Control


@export var Name : String
@export var CName : String
@export var texture : Texture
@export var level_index : int
@export var texture_rect : TextureRect
@export var button : Button

signal on_button_press


func _ready() -> void:
	texture_rect.texture = texture
	button.pressed.connect(on_button_pressed)
	button.text = CName if GameManager.language == "简体中文" else Name
	
	var star = GameManager.level_data[str(level_index)]
	if star == -1:
		button.disabled = true
		button.add_theme_color_override("font_color", Color.GRAY)
		texture_rect.self_modulate = Color.BLACK
	elif star == 0:
		button.disabled = false
		button.add_theme_color_override("font_color", Color.WHITE)
	elif star == 1:
		button.disabled = false
		button.add_theme_color_override("font_color", Color.GREEN)
	elif star == 3:
		button.disabled = false
		button.add_theme_color_override("font_color", Color.GOLD)


func on_button_pressed() -> void:
	GameManager.level_index = level_index
	on_button_press.emit()
