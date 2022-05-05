extends Line2D


onready var ray = get_parent()	

func _physics_process(_delta):
	
	if ray.is_colliding():
		default_color = Color(1, 0, 0)
	else:
		default_color = Color(0, 1, 0)
	clear_points()
	add_point(ray.position)
	add_point(ray.cast_to)
