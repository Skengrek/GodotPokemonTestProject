extends Area2D

var direction = Vector2.RIGHT
var speed = 400

onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	


func fire():
	print('PEW')
