extends Control
class_name DialogManager

@onready var dialog_options_1: DialogOptions = %DialogOptions
@onready var dialog_options_2: DialogOptions = %DialogOptions2
@onready var dialog_options_3: DialogOptions = %DialogOptions3
@onready var options_group: Control = %OptionsGroup
@onready var darken_dia_bg: ColorRect = %DarkenDiaBg

var dialog_group : DialogueGroup
var dialog_index :int = -1

@export var test_dialogue : DialogueGroup

@onready var text_dia_box: RichTextLabel = $TextDiaBox

func _ready() -> void:
	# init_dialog(test_dialogue)
	for child in options_group.get_children():
		var option = child as DialogOptions
		option.my_pressed.connect(_on_select)

## 开始对话
func init_dialog(group :DialogueGroup) -> void:
	dialog_index = 0
	dialog_group = group
	_play_dialog_block(dialog_group.dialogue_list[dialog_index])

## 结束对话
func end_dialog() -> void:
	dialog_group = null
	
	var tween = create_tween()
	tween.tween_property(darken_dia_bg, "modulate:a", 0.0, 0.2)
	
	for child in options_group.get_children():
		child.hide()
		
	## 测试
	text_dia_box.text = ""

## 点击选项
func _on_select(index : int) -> void:
	var k = 0
	for child in options_group.get_children():
		if k != index:
			var option = child as DialogOptions
			option.disabled = true
			
			var tween = create_tween()
			tween.tween_property(
				option, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.2)
		k += 1
	dialog_index = dialog_group.dialogue_list[dialog_index]\
	.options_to_index[index]
	
	var tween = create_tween()
	for i in 5:
		tween.tween_property(options_group.get_child(index)
		, "modulate:a", 0.4, 0.1) # 淡出
		tween.tween_property(options_group.get_child(index)
		, "modulate:a", 1.0, 0.1) # 淡入
	await tween.finished
	if dialog_index == -1:
		end_dialog()
	else:
		_play_dialog_block(dialog_group.dialogue_list[dialog_index])
	

## 播放对话块
func _play_dialog_block(dialogue : Dialogue) -> void:
	text_dia_box.text = dialogue.main_text
	text_dia_box.visible_ratio = 0
	options_group.modulate = Color(1.0, 1.0, 1.0, 0.0)
	options_group.position.x = -30
	
	var k = 0
	for i in dialogue.options_text:
		var property_name = "dialog_options_" + str(k + 1)
		var option_node = get(property_name) as DialogOptions
		option_node.show()
		option_node.disabled = false
		option_node.modulate = Color(1.0, 1.0, 1.0, 1.0)
		option_node.btn_text = i
		k += 1
	
	var tween = create_tween()
	tween.tween_property(text_dia_box, "visible_ratio", 1.0, 1)
	await tween.finished
	var tween_2 = create_tween().set_parallel()
	tween_2.tween_property(
		options_group, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1)
	tween_2.tween_property(
		options_group, "position", Vector2(0,0), 0.5).set_ease(Tween.EASE_OUT)
	
