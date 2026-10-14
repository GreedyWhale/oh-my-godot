extends Container
class_name PowerSwitch


## 通知外部：我的状态发生变化
signal state_changed(
	switch_id: int,
	is_turned_on: bool
)


## 组件身份
var switch_id: int = 0


## 组件状态
var is_turned_on: bool = false


@onready var button: Button = $Button
@onready var indicator: Panel = $Indicator


var indicator_style: StyleBoxFlat



func _ready() -> void:

	# 复制样式资源，避免修改共享资源
	indicator_style = (
		indicator
		.get_theme_stylebox("panel")
		.duplicate()
	)

	indicator.add_theme_stylebox_override(
		"panel",
		indicator_style
	)


	button.pressed.connect(
		_on_button_pressed
	)


	update_indicator()



## 外部初始化接口
func initialize(
	id: int,
	text: String
) -> void:

	switch_id = id
	button.text = text



func _on_button_pressed() -> void:

	set_state(
		not is_turned_on
	)
	
	state_changed.emit(
		switch_id,
		is_turned_on
	)



## 修改状态统一入口
func set_state(value: bool) -> void:

	# 状态没有变化，不做任何事情
	if is_turned_on == value:
		return


	is_turned_on = value


	update_indicator()




## 更新视觉表现
func update_indicator() -> void:

	if indicator_style == null:
		return


	indicator_style.bg_color = (
		Color.GREEN
		if is_turned_on
		else Color.GRAY
	)
