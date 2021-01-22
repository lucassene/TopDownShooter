extends State

var player_controller

func enter(actor, _delta = 0.0):
	print("Walking")
	player_controller = actor.get_player_controller()
	player_controller.set_current_speed(player_controller.WALK_SPEED)

func update(actor,delta):
	var velocity = actor.move(delta)
	if velocity.length() <= 1.0:
		state_machine.set_state("Idle")

