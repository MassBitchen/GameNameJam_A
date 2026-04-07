@tool
extends Button
class_name DialogOptions

@onready var options_text: RichTextLabel = %OptionsText
@onready var bg: PanelContainer = %Bg
@onready var touch: Control = %Touch

@export var btn_text: String = "" :
	set(val):
		%OptionsText.text = val
		btn_text = val

@export var index: int = 0

signal hovered()
signal unhovered()
signal my_pressed(index : int)

var is_mouse_over: bool = false
var is_button_down: bool = false

func _ready() -> void:
	touch.mouse_entered.connect(_on_mouse_entered)
	touch.mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _process(delta: float) -> void:
	bg.size.x = options_text.size.x + 4
	bg.position.x = options_text.position.x - 2
	
	touch.size.x = options_text.size.x + 4
	touch.position.x = options_text.position.x - 2

func _on_mouse_entered() -> void:
	bg.show()

func _on_mouse_exited() -> void:
	bg.hide()

func _on_button_down() -> void:
	pass

func _on_button_up() -> void:
	pass

func _pressed() -> void:
	my_pressed.emit(index)
