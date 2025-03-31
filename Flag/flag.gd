extends Node2D


@export var star_flag : int
@export var area : Area2D


func _ready() -> void:
	area.body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if body == GameManager.player:
		if star_flag == 0:
			var string = "你抵达了终点" if GameManager.language == "简体中文" else "You've reached the end"
			GameManager.game_menu.show_tip(string, Color.GREEN, 2.5)
		else:
			var string = "你发现了更多" if GameManager.language == "简体中文" else "You discover more"
			GameManager.game_menu.show_tip(str(star_flag)+"/4 " + string, Color.GOLD, 2.5)
		await get_tree().create_timer(3.0).timeout
		GameManager.win(1 if star_flag == 0 else 3)
