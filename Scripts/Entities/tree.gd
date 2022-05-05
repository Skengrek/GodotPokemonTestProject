extends StaticBody2D


var fireRate = 1 # seconds
var damage = 1 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func setOptions(newFireRate, newDamage):
	fireRate = newFireRate
	damage = newDamage
	
	
func fire():

