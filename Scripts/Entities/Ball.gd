extends Area2D


var speed = 1000
var direction = Vector2.RIGHT


func _ready():
	pass


func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_Area2D_body_entered(_body):
	if _body.has_method('hit'):
		_body.hit(1)
	queue_free()
