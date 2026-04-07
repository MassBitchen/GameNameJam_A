extends Node

enum Bus { MASTER, SFX, BGM }

@onready var sfx_node: Node = %SFX
@onready var bgm: Node = %BGM
@onready var bgm_1: AudioStreamPlayer = %bgm_1


var sfx_dictionary :Dictionary = {
	
}


## 播放音频
func play_sfx(name: String) -> void:
	var sfx = AudioStreamPlayer.new()
	sfx.stream = sfx_dictionary[name]
	sfx_node.add_child(sfx)
	sfx.bus = "SFX"
	sfx.play()
	
	await get_tree().create_timer(sfx.stream.get_length()).timeout
	sfx.queue_free()

## BGM
func play_bgm(index: int) -> void:
	var bgm_name = "bgm_" + str(index + 1)
	var bgm = get(bgm_name) as AudioStreamPlayer
	bgm.play()
