extends Container

signal onPressed

var is_turned_on = false
var indicator_original_bg_color: Color
var indicator_original_style: StyleBoxFlat
@onready var indicator: Panel = get_node('Indicator')
@onready var button: Button = get_node('Button')

func _ready() -> void:
	indicator_original_style = indicator.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	indicator_original_bg_color = indicator_original_style.bg_color
	indicator.add_theme_stylebox_override('panel', indicator_original_style)

func _on_button_pressed() -> void:
	is_turned_on = not is_turned_on
	indicator_original_style.bg_color = Color.GREEN if is_turned_on else indicator_original_bg_color
	print(indicator_original_style.bg_color)
	onPressed.emit()
	
func set_switch_name(name: String) -> void:
	button.text = name
