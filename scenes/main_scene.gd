extends Node2D
class_name MainScene

@export var title_screen : PackedScene
@export var battle_scene : PackedScene

@onready var root: Node2D = %GameRoot
@onready var popup_manager: PopupManager = %PopupManager

func _ready() -> void:
	AllScenes.main_scene = self
	AllScenes.popups = popup_manager
	
	enter_main_menu()

func root_clear() -> void:
	for child in root.get_children():
		child.queue_free()

func enter_main_menu() -> void:
	root_clear()
	var scene_ins = title_screen.instantiate()
	root.add_child(scene_ins)

func new_game() -> void:
	root_clear()
	var scene_ins = battle_scene.instantiate()
	root.add_child(scene_ins)
