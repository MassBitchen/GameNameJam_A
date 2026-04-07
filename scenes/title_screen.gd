extends Node2D
class_name TitleScreen

@export var options_popup : PackedScene
@export var credits_popup : PackedScene

@onready var main: Control = %Main
@onready var start_btn: TextButton = %StartBtn
@onready var options_btn: TextButton = %OptionsBtn
@onready var credits_btn: TextButton = %CreditsBtn
@onready var quit_btn: TextButton = %QuitBtn

func _ready() -> void:
	start_btn.pressed.connect(_on_start)
	options_btn.pressed.connect(_on_options)
	credits_btn.pressed.connect(_on_credits)
	quit_btn.pressed.connect(_on_quit)

func _on_start() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(main, "position", Vector2(-250, 0), 0.2)
	
	await tween.finished
	AllScenes.main_scene.new_game()

func _on_options() -> void:
	AllScenes.popups.add_popup(options_popup.instantiate())
	AllScenes.popups.focus_curr()

func _on_credits() -> void:
	AllScenes.popups.add_popup(credits_popup.instantiate())
	AllScenes.popups.focus_curr()

func _on_quit() -> void:
	pass
