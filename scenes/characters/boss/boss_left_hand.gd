extends CharacterBody2D
class_name BossLeftHand

@onready var timer_1: Timer = %Timer1
@onready var timer_2: Timer = %Timer2
@onready var timer_3: Timer = %Timer3

enum State{
	IDLE,
	MOVE,
}

## 记录是否在释放中
var is_move :bool = false

func _input(event: InputEvent) -> void:
	if not is_move:
		if event.is_action_pressed("Q") and timer_1.is_stopped():
			## skill1
			_skill_1()
		elif event.is_action_pressed("W") and timer_2.is_stopped():
			## skill2
			_skill_2()
		elif event.is_action_pressed("E") and timer_3.is_stopped():
			## skill3
			_skill_3()

func tick_physics(state: State, delta: float) -> void:
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

## 技能
func _skill_1() -> void:
	pass

func _skill_2() -> void:
	pass

func _skill_3() -> void:
	pass
