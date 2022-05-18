extends Area2D


var speed = 500
var direction = Vector2.LEFT
var damage = 2


func _ready():
	print('OK DUDE')


func _process(delta):
	translate(direction.normalized() * speed * delta)
	
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		queue_free()
