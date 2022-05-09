extends KinematicBody2D


onready var lifeBar = $CenterContainer/lifeBar
var life = 10
var alive = true
var rng = RandomNumberGenerator.new()

onready var cooldown = $Cooldown
onready var animPlayer = $AnimationTree
onready var animState = animPlayer.get('parameters/playback')
onready var attackRayCast = $RayCasts/attack

var speed = 20
var nextPosition = Vector2.ZERO

func _ready():
	animState.start('Move')
	nextPosition = position


func hit(dmg):
	life -= dmg
	if life<=0:
		queue_free()
		

func _process(_delta):
	
	if nextPosition == global_position:
		var x = rng.randi_range(5, 15)
		var y = rng.randi_range(5, 15)
		print(nextPosition)
		nextPosition = Vector2(x, y)
		var success = move_and_slide(nextPosition)
	
	if attackRayCast.is_colliding():
		print('Test')
		animState.start('Attack')
	
