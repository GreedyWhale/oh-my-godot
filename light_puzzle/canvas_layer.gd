extends CanvasLayer

signal restart

@onready var result_ui = $ResultUI
@onready var result_lable = $ResultUI/Label
@onready var step_label: Label = $Steps
@onready var missions_label: Label = $Missions

var _tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func init_result_ui() -> void:
	result_lable.pivot_offset_ratio = Vector2(0.5, 0.5)
	result_lable.scale = Vector2.ZERO
	result_ui.hide()

func show_result(text: String) -> void:
	# 先显示，再设置文字，让布局正常更新
	result_ui.show()
	result_lable.text = text

	# 每次从零开始缩放，并停止上一次未完成的动画
	if _tween and _tween.is_valid():
		_tween.kill()
	result_lable.scale = Vector2.ZERO

	_tween = create_tween()
	_tween.tween_property(result_lable, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func set_steps(step: int) -> void:
	step_label.text = "步数: %d" % step
	
func set_missions(missions: Array[bool]) -> void:
	var text = " ".join(missions.map(
		func(s: bool) -> String: return "亮" if s else "灭"
	))
	missions_label.text = "任务: %s" % text


func _on_button_pressed() -> void:
	result_ui.hide()
	restart.emit()
