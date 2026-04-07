extends Camera2D
class_name MyCamera

var target_position : Vector2 = Vector2.ZERO
## 是否跟随目标点
@export var is_follow : bool = true
@export var follow_node : Node2D = null
## 跟随速度，值越大跟随越快
@export var follow_speed : float = 5.0
@export var offest_pos : Vector2 = Vector2(0, 0)


var strength := 0.0
var t = true

var shake_amount = 0
var shake_duration = 0
var shake_offset := Vector2.ZERO  # 单独存储随机震动偏移

# 果冻抖动参数
var jelly_damping : float = 0.8       # 阻尼系数 (0-1)
var jelly_frequency : float = 15.0    # 抖动频率
var jelly_max_offset : float = 30.0   # 最大偏移量

var jelly_offset : Vector2 = Vector2.ZERO
var jelly_velocity : Vector2 = Vector2.ZERO
var jelly_active : bool = false

func _ready() -> void:
	make_current()

func _physics_process(delta: float) -> void:
	if is_follow:
		_follow_pos(delta)

func _process(delta: float) -> void:
	# 处理随机震动
	shake_offset = Vector2.ZERO
	if shake_duration > 0:
		shake_offset = Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
		shake_duration -= delta
	
	# 处理果冻抖动
	if jelly_active:
		_update_jelly_effect(delta)
	
	# 合并两种效果
	offset = shake_offset + jelly_offset

func _follow_pos(delta: float) -> void:
	target_position = $"../Game/Hero".global_position
	var p1 : Vector2 = target_position + offest_pos
	# 帧率无关的指数衰减插值
	var weight = 1.0 - exp(-follow_speed * delta)
	global_position = global_position.lerp(p1, weight)

# 随机震动函数
func shake(amount: float, duration: float):
	shake_amount = amount
	shake_duration = duration

# 果冻抖动函数
func jelly_shake(intensity: float = 1.0):
	# 根据强度设置初始速度
	jelly_velocity = Vector2(
		randf_range(-jelly_frequency, jelly_frequency) * intensity,
		randf_range(-jelly_frequency, jelly_frequency) * intensity
	)
	jelly_active = true

# 更新果冻抖动效果
func _update_jelly_effect(delta: float):
	# 应用弹性力
	var acceleration = -jelly_offset * jelly_frequency * jelly_frequency
	jelly_velocity += acceleration * delta
	
	# 应用阻尼
	jelly_velocity *= pow(jelly_damping, delta * jelly_frequency)
	
	# 更新位置
	jelly_offset += jelly_velocity * delta
	
	# 限制最大偏移
	if jelly_offset.length() > jelly_max_offset:
		jelly_offset = jelly_offset.normalized() * jelly_max_offset
	
	# 当抖动足够小时停止效果
	if jelly_offset.length_squared() < 0.1 and jelly_velocity.length_squared() < 0.1:
		jelly_offset = Vector2.ZERO
		jelly_velocity = Vector2.ZERO
		jelly_active = false
