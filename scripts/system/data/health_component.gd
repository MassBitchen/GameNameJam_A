extends Node
class_name HealthComponent

## 最大生命值
@export var max_health :int = 100
## 当前生命值
var current_health :int

## 生命值变化
signal health_changed(new_health: int, max_health: int)
## 死亡信号
signal died

func _ready() -> void:
	current_health = max_health

## 收到伤害
func take_damage(amount: int) -> void:
	current_health = maxi(0, current_health - amount)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		died.emit()

## 治疗
func heal(amount: int) -> void:
	current_health = mini(max_health, current_health + amount)
	health_changed.emit(current_health, max_health)

## 是否存活
func is_alive() -> bool:
	return current_health > 0
