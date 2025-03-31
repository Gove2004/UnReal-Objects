extends Node2D


var move_timer = 0.0
var move_cd = 5.0


@export var w_ray : RayCast2D
@export var a_ray : RayCast2D
@export var s_ray : RayCast2D
@export var d_ray : RayCast2D

@export var area : Area2D


func _ready() -> void:
	GameManager.clear_action_array()
	area.body_entered.connect(on_body_entered)


func _physics_process(delta: float) -> void:
	move_timer += delta
	if move_timer >= move_cd:
		move_timer -= move_cd
		execute_move()


var all_dirctions = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
func execute_move() -> void:
	var empty_direction = []
	for dir in all_dirctions:
		if ray_check(dir):
			empty_direction.append(dir)
	var direction = Vector2i.ZERO if empty_direction.is_empty() else empty_direction.pick_random()
	var tween = get_tree().create_tween()
	var new_position = Vector2(
		position.x + direction.x * GameManager.SIZE, 
		position.y + direction.y * GameManager.SIZE
	)
	tween.tween_property(self, "position", new_position, 0.5)
	tween.play()


func ray_check(direction: Vector2i) -> bool:
	var collider = null
	if direction == Vector2i.UP:
		collider = w_ray.get_collider()
	elif direction == Vector2i.LEFT:
		collider = a_ray.get_collider()
	elif direction == Vector2i.DOWN:
		collider = s_ray.get_collider()
	elif direction == Vector2i.RIGHT:
		collider = d_ray.get_collider()
	
	if collider == GameManager.player:
		return true
	return collider == null


func on_body_entered(body: Node2D) -> void:
	if body == GameManager.player:
		var string = "恶魔杀死了你" if GameManager.language == "简体中文" else "The devil has killed you"
		GameManager.game_menu.show_tip(string, Color.RED, 2.5)
		await get_tree().create_timer(2.5).timeout
		GameManager.lose()
