extends Control

@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func show_result(text:String):

	label.text = text
	print(label.size, " min=", label.get_minimum_size())
	label.pivot_offset = label.get_minimum_size() / 2
	label.scale = Vector2.ZERO
	show()
	
	var tween = create_tween()


	tween.tween_property(
		label,
		"scale",
		Vector2.ONE,
		0.5
	).set_trans(
		Tween.TRANS_BACK
	).set_ease(
		Tween.EASE_OUT
	)
