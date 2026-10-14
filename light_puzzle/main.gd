extends Node


var power_switch_scene: PackedScene = preload(
	"res://light_puzzle/power_switch.tscn"
)

var switchs: Array[PowerSwitch] = []
var missions: Array[bool] = []
var steps_left = 0
const TOTAL_STEPS = 5
const SWITCH_BUTTON_COUNT := 3



func _ready() -> void:
	steps_left = TOTAL_STEPS
	$CanvasLayer.set_steps(TOTAL_STEPS)
	$CanvasLayer.restart.connect(on_restart)
	create_power_switches()



func create_power_switches() -> void:

	missions = generate_random_states(SWITCH_BUTTON_COUNT)
	$CanvasLayer.set_missions(missions)
	for i in SWITCH_BUTTON_COUNT:
		
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
			"Power Switch %d" % (i + 1)
		)


		# 监听事件
		switch.state_changed.connect(
			_on_switch_changed
		)
		
		switchs.append(switch)




func _on_switch_changed(id: int, value: bool) -> void:
	consume_step()
	check_result()


# 只负责"消耗一步"：修改状态 + 更新 UI
func consume_step() -> void:
	steps_left -= 1
	$CanvasLayer.set_steps(steps_left)


# 只负责"判断结果"：纯查询，不修改任何状态
func get_result() -> String:
	var results := []
	for item in switchs:
		results.append(item.is_turned_on)

	if results == missions and steps_left >= 0:
		return "挑战成功"
	if steps_left <= 0:
		return "挑战失败"
	return ""


# 根据结果决定是否展示结算界面
func check_result() -> void:
	var result := get_result()
	if result != "":
		$CanvasLayer.show_result(result)

func on_restart() -> void:
	steps_left = TOTAL_STEPS
	$CanvasLayer.set_steps(steps_left)

	for item in switchs:
		item.set_state(false)
		
func generate_random_states(count: int) -> Array[bool]:
	var states: Array[bool] = []
	for i in count:
		states.append(randf() < 0.5)

	# 保证至少有一个 true
	if not states.has(true):
		states[randi() % count] = true

	return states
