extends Node2D

const DIRECTIONAL_RADIUS = 384/2
const BUTTON_RADIUS = 192/2
const BOTTOM_MARGIN = 60
const LEFT_MARGIN = 100
const RIGHT_MARGIN = 100

onready var directional = $Directional
onready var action_button = $ActionButton
onready var interact_button = $InteractButton

var player_controller
var is_moving = false

func _unhandled_input(event):
	if is_moving and (event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed())):
		if event.get_index() == 0:
			set_next_direction(event)
			return
	if is_moving and event is InputEventScreenTouch and !event.is_pressed():
		if event.get_index() == 0:
			player_controller.set_next_direction(Vector2.ZERO)
			is_moving = false

func initialize(controller):
	player_controller = controller
	set_buttons_position()

func set_buttons_position():
	var screen_size = get_viewport_rect().size
	var directional_position = Vector2(DIRECTIONAL_RADIUS + LEFT_MARGIN,screen_size.y - DIRECTIONAL_RADIUS - BOTTOM_MARGIN)
	directional.global_position = directional_position
# warning-ignore:integer_division
	var action_position = Vector2(screen_size.x - BUTTON_RADIUS - RIGHT_MARGIN * 3.5,screen_size.y - BUTTON_RADIUS * 1.5 - BOTTOM_MARGIN / 2)
	action_button.global_position = action_position
	var interact_position = Vector2(screen_size.x - BUTTON_RADIUS - RIGHT_MARGIN,screen_size.y - BUTTON_RADIUS * 2 - BOTTOM_MARGIN * 3)
	interact_button.global_position = interact_position

func set_next_direction(event):
	if event.get_index() == 0:
		var origin_position = Vector2(directional.global_position.x,directional.global_position.y)
		player_controller.set_next_direction(origin_position.direction_to(event.position))

func _on_DirectionalArea_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		is_moving = true
		set_next_direction(event)

func _on_ActionArea_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		player_controller.fire()

func _on_InteractArea_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		print("interact!")
