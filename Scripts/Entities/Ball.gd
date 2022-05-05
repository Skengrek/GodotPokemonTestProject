extends Area2D


var speed = 500
var direction = Vector2.RIGHT
var damage = 2

var explosion = preload("res://Scenes/Singletons/explosions.tscn")


func _ready():
	pass


func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_Area2D_body_entered(_body):
	if _body.has_method('hit'):
		_body.hit(2)
		var _explosion = explosion.instance()
		_explosion.global_position = global_position 
		_explosion.emitting = true
		_explosion.one_shot = true
		get_tree().get_root().add_child(_explosion)
	queue_free()

