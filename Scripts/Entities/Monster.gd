extends KinematicBody2D


onready var lifeBar = $CenterContainer/lifeBar
var life = 10
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func hit(dmg):
	life -= dmg
	if life<=0:
		queue_free()


func _process(delta):
	lifeBar.value = life
