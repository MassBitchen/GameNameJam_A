extends Control
class_name OptionsPopup

@onready var back_btn: TextButton = $BackBtn

signal back()

func _ready() -> void:
	back_btn.pressed.connect(_on_back)

func _on_back() -> void:
	back.emit()
