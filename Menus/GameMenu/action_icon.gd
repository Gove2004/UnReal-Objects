extends Control


@export var audioplayer : AudioStreamPlayer
@export var animator : AnimationPlayer
@export var button : Button
@export var action : Action


func _ready() -> void:
	button.pressed.connect(on_button_pressed)
	set_action(action)


func set_action(act: Action) -> void:
	action = act
	if action == null:
		visible = false
		button.disabled = true
		button.text = ""
	else:
		visible = true
		button.disabled = false
		var descrip_str = action.Cdescription if GameManager.language == "简体中文" else action.description
		button.text = "< " + action.letter + " >" + "\n----------\n" + descrip_str
		
		var shortcut = Shortcut.new()
		var event = InputEventKey.new()
		event.keycode = KEY_A + (action.letter.unicode_at(0) - 'A'.unicode_at(0))
		var event_array = []
		event_array.append(event)
		shortcut.events = event_array
		button.shortcut = shortcut
		button.tooltip_text = ""


func on_button_pressed() -> void:
	audioplayer.play()
	animator.play("pressed")
	GameManager.add_commands_on_player(action.commands)
