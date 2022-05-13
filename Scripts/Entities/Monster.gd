extends KinematicBody2D


onready var lifeBar = $CenterContainer/lifeBar
var life = 100
var alive = true
var rng = RandomNumberGenerator.new()

var state = 0b01

onready var cooldown = $Cooldown
var canAttack = true
onready var animPlayer = $AnimationTree
onready var animState = animPlayer.get('parameters/playback')
onready var attackRayCast = $RayCasts/attack

var velocity = Vector2.ZERO
var canMove = true

var speed = 100
var nextPosition = Vector2.ZERO
var startingDist = 0


func _ready():
	animState.start('Move')
	nextPosition = position
	velocity = Vector2(speed, speed)
	nextPosition = global_position + Vector2(500, 0)

func hit(dmg):
	life -= dmg
	if life<=0:
		queue_free()
		

func _process(_delta):
	if attackRayCast.is_colliding() and canAttack:
		animState.start('Attack')
		
		
func _physics_process(delta):
	computeVelocity(delta)
	if velocity == Vector2.ZERO:
		generateNewCoordinate()
	if canMove:
		move_and_slide(velocity)
	
func computeVelocity(delta):
	if canMove:
		var distX = nextPosition.x-global_position.x
		var distY = nextPosition.y-global_position.y
		velocity.x = speed
		velocity.y = speed
		if speed*delta < sqrt(pow(distX,2)):
			velocity.x = speed
			if distX<0:
				velocity.x = -speed
		else:
			velocity.x = 0
		if speed*delta < sqrt(pow(distY,2)):
			velocity.y = speed
			if distY<0:
				velocity.y = -speed
		else:
			velocity.y = 0
	

func generateNewCoordinate():
	var randomVector = Vector2(rng.randf_range(0, 1000)-500,
						   rng.randf_range(0, 1000)-500)
	nextPosition = global_position + randomVector
	
	print(randomVector, nextPosition)


func _on_AggroArea_body_entered(body):
	if body.name == "Player":
		nextPosition = body.global_position
