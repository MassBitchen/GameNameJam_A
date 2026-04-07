extends CharacterBody2D
class_name Player

## 决定是否又玩家控制
@export var can_control : bool = true
# 移动参数
var run_speed = 80
var acceleration = run_speed / 0.1
var mov_direction := Vector2.ZERO

enum State{
	PLAYER, # 玩家控制
	IDLE,
	MOVE,
}

func tick_physics(state: State, delta: float) -> void:
	match state:
		State.PLAYER:
			_player_move(delta,1)
		State.IDLE:
			pass
		State.MOVE:
			pass

func get_next_state(state: State) -> int:
	if can_control:
		return State.PLAYER
	match state:
		State.PLAYER:
			if not can_control:
				return State.IDLE
		State.IDLE:
			pass
		State.MOVE:
			pass
	return StateMachine.KEEP_CURRENT

func transition_state(_from: State, to: State) -> void:
	match to:
		State.PLAYER:
			pass
		State.IDLE:
			pass
		State.MOVE:
			pass

# --- 私有函数 ---
## player_move
func _player_move(delta: float,rate: float) -> void:
	#input
	var movement_H := Input.get_axis("move_left", "move_right")
	var movement_V := Input.get_axis("move_up", "move_down")
	mov_direction = Vector2(movement_H, movement_V).normalized()
	velocity.x = move_toward(velocity.x, mov_direction.x * run_speed * rate, acceleration * delta)
	velocity.y = move_toward(velocity.y, mov_direction.y * run_speed * rate, acceleration * delta)
	move_and_slide()
