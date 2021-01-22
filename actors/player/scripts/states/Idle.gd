extends State

var player_controller

func enter(actor, _delta = 0.0):
	print("Idle")
	player_controller = actor.get_player_controller()

func update(actor,delta):
	var velocity = actor.move(delta)
	if velocity.length() != 0.0:
		state_machine.set_state("Walking")



