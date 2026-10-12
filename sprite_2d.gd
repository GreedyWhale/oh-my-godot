extends Sprite2D

# 每秒旋转的角度
var angular_speed = PI
# 每秒移动的距离
var speed = 400

func _process(delta: float) -> void:
	rotation += angular_speed * delta
	
	# Vector2.UP.rotated(rotation) 找到和节点相同方向的向上的向量
	# 将速率转换成速度，速度指的是既有方向也有大小
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
	print(position)
