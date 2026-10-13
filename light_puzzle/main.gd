extends Node

var power_switch_scene: PackedScene = preload("res://light_puzzle/power_switch.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initPowerSwitch()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func initPowerSwitch() -> void:
	for n in 3:
		var button: Button = power_switch_scene.instantiate()
		var order_number = n + 1
		button.text = "Power Switch %s" % order_number
		button.pressed.connect(on_power_switch_pressed.bind(order_number))
		$BoxContainer.add_child(button)
		
func on_power_switch_pressed(order_number: int) -> void:
	print("开关 %s 被点击了" % order_number)
