extends Node2D

var damage = 1
var canShoot = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func setFirerate(cd):
	get_node("Cooldown").wait_time = cd
	
func fire(gpos, direction):
	if canShoot == true:
		var _ball = get_node("Ball")
		_ball.global_position = gpos
		_ball.direction = direction
		get_tree().get_root().add_child(_ball)
		get_node("Cooldown").start()
		canShoot = false
	

func _on_Cooldown_timeout():
	canShoot = true
