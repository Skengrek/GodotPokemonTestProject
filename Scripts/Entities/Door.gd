extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_entered(body):
	if body.name == 'Player':
		visible = true
		$AnimationPlayer.play("openDoor")
		

func closeDoor():
	$AnimationPlayer.play("closeDoor")
