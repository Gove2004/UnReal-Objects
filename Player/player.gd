extends Node2D


var able_move = true
var is_moveing = false
var commands_quene : Array[String]

@export var animator : AnimatedSprite2D

@export var w_ray : RayCast2D
@export var a_ray : RayCast2D
@export var s_ray : RayCast2D
@export var d_ray : RayCast2D

var last_move_array = []


func _ready() -> void:
	GameManager.player = self
	GameManager.clear_action_array()


func add_command(command: String) -> void:
	if is_moveing == true or able_move == false:
		return
	commands_quene.append(command)


func command_to_direction(command: String) -> Vector2i:
	if command == 'W':
		return Vector2i.UP
	elif command == 'A':
		return Vector2i.LEFT
	elif command == 'S':
		return Vector2i.DOWN
	elif command == 'D':
		return Vector2i.RIGHT
	else:
		printerr("未知命令")
		return Vector2i.ZERO


func execute_move() -> void:
	if is_moveing == true:
		return
	last_move_array.clear()
	var direction = Vector2i.ZERO
	while commands_quene.size() > 0:
		is_moveing = true
		var command = commands_quene.pop_front()
		direction = command_to_direction(command)
		if ray_check(direction):
			last_move_array.append(direction)
			var tween = get_tree().create_tween()
			var new_position = Vector2(
				position.x + direction.x * GameManager.SIZE, 
				position.y + direction.y * GameManager.SIZE
			)
			tween.tween_property(self, "position", new_position, 0.5)
			tween.play()
			play_walk_animation(direction)
			await tween.finished
			continue
	is_moveing = false
	play_idle_animation(direction)


func undo() -> void:
	print("undo")
	last_move_array.reverse()
	var reverse_direction = Vector2i.ZERO
	while last_move_array.size() > 0:
		is_moveing = true
		reverse_direction = last_move_array.pop_front() * -1
		if ray_check(reverse_direction):
			var tween = get_tree().create_tween()
			var new_position = Vector2(
				position.x + reverse_direction.x * GameManager.SIZE, 
				position.y + reverse_direction.y * GameManager.SIZE
			)
			tween.tween_property(self, "position", new_position, 0.5)
			tween.play()
			play_walk_animation(reverse_direction)
			await tween.finished
			continue
	is_moveing = false
	play_idle_animation(reverse_direction)


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
	return collider == null


func play_walk_animation(direction: Vector2i) -> void:
	if direction == Vector2i.UP:
		animator.play("W_Walk")
	elif direction == Vector2i.LEFT:
		animator.flip_h = true
		animator.play("D_Walk")
	elif direction == Vector2i.DOWN:
		animator.play("S_Walk")
	elif direction == Vector2i.RIGHT:
		animator.flip_h = false
		animator.play("D_Walk")


func play_idle_animation(direction: Vector2i) -> void:
	if direction == Vector2i.UP:
		animator.play("W_Idle")
	elif direction == Vector2i.LEFT:
		animator.flip_h = true
		animator.play("D_Idle")
	elif direction == Vector2i.DOWN:
		animator.play("S_Idle")
	elif direction == Vector2i.RIGHT:
		animator.flip_h = false
		animator.play("D_Idle")
