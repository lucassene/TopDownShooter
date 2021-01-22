extends Node2D

onready var ground_map = $GroundMap
onready var player = $Player

func _ready():
	player.initialize()

func get_camera_limits():
	var map_rect = ground_map.get_used_rect()
	var cell_size = ground_map.get_cell_size()
	return Vector2(map_rect.size.x * cell_size.x,map_rect.size.y * cell_size.y * -1)

