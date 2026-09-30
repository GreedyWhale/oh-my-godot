extends CharacterBody2D

@export var config: PlayerConfig

@onready var label: Label = $Label

var current_stamina: float

func _ready() -> void:
	current_stamina = config.MAX_STAMINA

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
	
	if Input.is_action_pressed("sprint"):
		drain_stamina(delta)
	else:
		regenerate_stamina(delta)

	var current_speed = config.move_speed * config.sprint_multiplier if Input.is_action_pressed("sprint") and current_stamina > 0 else config.move_speed
	velocity = direction * current_speed
	move_and_slide()
	
func drain_stamina(delta) -> void:
	var stamina_drain_rate = config.MAX_STAMINA / config.MAX_SPRINT_DURATION
	current_stamina -= stamina_drain_rate * delta
	current_stamina = max(0, current_stamina)

func regenerate_stamina(delta) -> void:
	var stamina_recovery_rate = config.MAX_STAMINA / config.MAX_RECOVERY_DURATION
	current_stamina += stamina_recovery_rate * delta
	current_stamina = min(config.MAX_STAMINA, current_stamina)
