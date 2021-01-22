extends RayCast2D

onready var sprite: Sprite = $Sprite

func _physics_process(_delta):
	if is_colliding():
		var point = to_local(get_collision_point())
		sprite.region_rect.end.y = point.y

