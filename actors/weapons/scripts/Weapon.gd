extends Node2D

onready var bullet_scene = preload("res://actors/weapons/scenes/Bullet.tscn")

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var bullet_emitter: Position2D = $BulletEmitter

export var DAMAGE = 5
export var BULLET_SPEED = 2000

func fire():
	animation_player.play("fire")

func shoot():
	var bullet = bullet_scene.instance()
	bullet.set_as_toplevel(true)
	bullet.global_position = bullet_emitter.global_position
	bullet.global_rotation_degrees = global_rotation_degrees
	bullet.apply_impulse(Vector2(),Vector2(0,-BULLET_SPEED).rotated(bullet.rotation))
	bullet.connect("on_target_hit",self,"_on_target_hit")
	add_child(bullet)

func _on_target_hit(body):
	body.add_damage(DAMAGE)
