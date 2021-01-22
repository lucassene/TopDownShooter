extends Node

onready var player = owner

export var WALK_SPEED = Global.TILE_SIZE * 6
export var ACCELERATION = 25
export var DECELERATION = 1
export var TURN_SPEED = 15

var state_machine
var current_speed setget set_current_speed,get_current_speed
var next_direction = Vector2.ZERO setget set_next_direction,get_next_direction
var next_angle = 0.0 setget ,get_next_angle

func set_current_speed(value):
	current_speed = value

func get_current_speed():
	return current_speed

func set_next_direction(direction):
	next_direction = direction

func get_next_direction():
	return next_direction

func get_next_angle():
	return next_angle

func initialize(fsm):
	state_machine = fsm
	current_speed = WALK_SPEED

func get_x_movement():
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func get_y_movement():
	return Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

func get_movement(delta):
	var movement = Vector2.ZERO
	if next_direction != Vector2.ZERO:
		next_angle = next_direction.angle_to(Vector2.UP) * -1
		movement = movement.linear_interpolate(next_direction * current_speed,ACCELERATION * delta)
	else:
		movement = movement.linear_interpolate(next_direction * current_speed,DECELERATION * delta)
	return movement

func fire():
	player.fire()
