extends KinematicBody2D

export var HEALTH = 10

var current_health = HEALTH
var player

func _ready():
	current_health = HEALTH

func _physics_process(_delta):
	if player and is_player_in_sight():
		rotation = (player.position - position).angle() + deg2rad(90)

func is_player_in_sight():
	var space_state = get_world_2d().direct_space_state
	var target = space_state.intersect_ray(global_position,player.global_position,[self],collision_mask)
	if target.collider.is_in_group("Player"):
		return true
	return false

func add_damage(damage):
	current_health -= damage
	if current_health <= 0:
		queue_free()

func _on_FieldOfView_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_FieldOfView_body_exited(body):
	if body.is_in_group("Player"):
		player = null
