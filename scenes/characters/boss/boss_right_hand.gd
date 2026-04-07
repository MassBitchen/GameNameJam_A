extends CharacterBody2D
class_name BossRightHand

enum State{
	IDLE,
	MOVE,
}

var run_speed = 200
var acceleration = run_speed / 0.1
var mov_direction := Vector2.ZERO

func _ready() -> void:
	add_to_group("hero")

func tick_physics(state: State, delta: float) -> void:
	_follow_mouse(delta)
	match state:
		State.IDLE:
			pass
		State.MOVE:
			pass

func get_next_state(state: State) -> int:
	match state:
		State.IDLE:
			pass
		State.MOVE:
			pass
	return StateMachine.KEEP_CURRENT

func transition_state(_from: State, to: State) -> void:
	match to:
		State.IDLE:
			pass
		State.MOVE:
			pass

func _follow_mouse(delta) -> void:
	var dir = (get_global_mouse_position() - global_position).normalized()
	if (get_global_mouse_position() - global_position).length() > 10:
		velocity.x = move_toward(velocity.x, dir.x * run_speed, acceleration * delta)
		velocity.y = move_toward(velocity.y, dir.y * run_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
		velocity.y = move_toward(velocity.y, 0, acceleration * delta)
	move_and_slide()
	
