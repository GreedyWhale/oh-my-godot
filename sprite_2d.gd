extends Sprite2D

var speed = 400.0
var angular_speed = PI

func _process(delta: float) -> void:
	var turn_input = Input.get_axis("ui_left", "ui_right")
	var move_input = Input.get_axis("ui_down", "ui_up")

	# 旋转
	rotation += angular_speed * turn_input * delta

	# 计算移动速度
	var move_direction = Vector2.UP.rotated(rotation)
	var velocity = move_direction * speed * move_input

	# 更新位置
	position += velocity * delta


func _on_button_pressed() -> void:
	set_process(not is_processing())
