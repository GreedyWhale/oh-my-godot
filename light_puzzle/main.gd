extends Node


var power_switch_scene: PackedScene = preload(
	"res://light_puzzle/power_switch.tscn"
)

var switch_states: Array[bool] = []



func _ready() -> void:

	create_power_switches()



func create_power_switches() -> void:


	for i in 3:
		switch_states.append(false)
		
		# 创建组件
		var switch: PowerSwitch = (
			power_switch_scene.instantiate()
		)


		# 加入 SceneTree
		$BoxContainer.add_child(
			switch
		)


		# 初始化组件
		switch.initialize(
			i,
			"Power Switch %s" % (i + 1)
		)


		# 监听事件
		switch.state_changed.connect(
			_on_switch_changed
		)




func _on_switch_changed(
	id: int,
	value: bool
) -> void:
	switch_states[id] = value
	if is_game_over():
		$CanvasLayer/ResultUI.show_result("挑战成功")
	
func is_game_over() -> bool:
	var turned_on_count = 0
	for item in switch_states:
		if item:
			turned_on_count += 1
	
	return turned_on_count == 2
