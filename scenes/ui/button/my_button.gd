@tool
extends Button
class_name MyButton

@onready var visuals: Control = %Visuals

signal hovered()
signal unhovered()

var is_mouse_over: bool = false
var is_button_down: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_mouse_entered() -> void:
	is_mouse_over = true
	hovered.emit()
	visuals.pivot_offset = visuals.size/2
	Springer.rotate(visuals, -6, 0, 600)

func _on_mouse_exited() -> void:
	is_mouse_over = false
	unhovered.emit()

func _on_button_down() -> void:
	Springer.squash(visuals, 0.08, -0.1, 1, 500, 12)
	is_button_down = true

func _on_button_up() -> void:
	is_button_down = false

func _pressed() -> void:
	Jumper.jump(self, Vector2.UP, 8, 0.1)
	Springer.squash(visuals, 0.2, -0.3, 1, 500, 12)
	Springer.rotate(visuals, 3, 0, 300)
