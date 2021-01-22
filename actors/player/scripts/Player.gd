extends KinematicBody2D

onready var state_machine: StateMachine = $StateMachine
onready var player_controller = $PlayerController
onready var camera: Camera2D = $Camera
onready var joystick = $CanvasLayer/Joystick
onready var sprite: Sprite = $Sprite
onready var weapon = $Weapon

var velocity = Vector2.ZERO

func get_player_controller():
	return player_controller

func get_velocity():
	return velocity

func _unhandled_input(event):
	state_machine.handle_input(event)

func _physics_process(delta):
	state_machine.update(delta)
	
func initialize():
	state_machine.initialize("Idle")
	player_controller.initialize(state_machine)
	joystick.initialize(player_controller)
	set_camera_limits()

func set_camera_limits():
	var limits = get_parent().get_camera_limits()
	camera.limit_left = 0
	camera.limit_right = limits.x
	camera.limit_top = limits.y
	camera.limit_bottom = 0

func move(delta):
	rotation = lerp_angle(rotation,player_controller.next_angle,player_controller.TURN_SPEED * delta)
	var movement = player_controller.get_movement(delta)
	velocity = move_and_slide(movement)
	return velocity

func fire():
	weapon.fire()
