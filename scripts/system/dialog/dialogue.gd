extends Resource
class_name Dialogue

## 主语句
@export_multiline var main_text :String
## 选项语句(为空则代表无)
@export_multiline var options_text :Array[String]
## 选项跳转索引(为空则代表无)
@export var options_to_index :Array[int]
## 主语句跟随目标
var main_entity : Node
