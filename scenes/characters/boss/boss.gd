extends CharacterBody2D
class_name boss

enum State{
	IDLE,
	MOVE,
}

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
