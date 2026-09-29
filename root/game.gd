extends Node2D

const player_scene = preload("res://player/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 创建玩家
	var player = player_scene.instantiate()
	add_child(player)
	player.initialize('Ozen')
