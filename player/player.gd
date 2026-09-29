extends CharacterBody2D

@onready var label: Label = $Label

const speed = 200.0

func initialize(_name := 'player') -> void:
	label.text = _name
	position = Vector2(20, 30)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * speed
	move_and_slide()
