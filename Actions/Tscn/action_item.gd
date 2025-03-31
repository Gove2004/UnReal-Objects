class_name ActionItem extends Node2D


@export var action : Action
@export var texture : Texture


func _ready() -> void:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.scale = Vector2.ONE * 0.5
	sprite.self_modulate = Color(0.1, 0.1, 0.1, 1.0)
	add_child(sprite)
	
	var label = Label.new()
	label.text = action.letter
	label.add_theme_font_size_override("font_size", 36)
	add_child(label)
	label.position -= label.size / 2
	
	var area = Area2D.new()
	var colliser = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(16, 16)
	colliser.shape = shape
	area.add_child(colliser)
	add_child(area)
	
	area.body_entered.connect(on_body_entered)
	
	z_index = 3


func on_body_entered(body: Node2D) -> void:
	if body == GameManager.player:
		print("拾取: ", action.letter)
		GameManager.add_new_action(action)
		queue_free()
