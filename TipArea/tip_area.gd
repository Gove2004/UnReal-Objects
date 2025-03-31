extends Area2D


@export var tip_str : String
@export var Ctip_str : String
@export var tip_color : Color = Color.WHITE
@export var tip_duration : float = 3.0


func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if body == GameManager.player:
		var string = Ctip_str if GameManager.language == "简体中文" else tip_str
		GameManager.game_menu.show_tip(string, tip_color, tip_duration)
		queue_free()
