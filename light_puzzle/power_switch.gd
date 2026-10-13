extends Button

var is_turned_on = false
@onready var original_style = get_theme_stylebox("normal")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	is_turned_on = not is_turned_on
	if is_turned_on:
		var style = original_style.duplicate()
		style.bg_color = Color.RED
		add_theme_stylebox_override("normal", style)
	else:
		add_theme_stylebox_override("normal", original_style)
