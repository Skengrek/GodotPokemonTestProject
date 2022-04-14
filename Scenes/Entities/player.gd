extends KinematicBody2D

export (int)var speed = 200
var velocity = Vector2()
var canMove = true

onready var isMoving = false
onready var animTree = $playerAnimTree
onready var animState = animTree.get('parameters/playback')

func _ready():
	animState.start('Idle')

func setMovement(_bool):
	print(_bool)
	canMove = _bool

func _physics_process(delta):
	if canMove:
		get_input()
		velocity = move_and_slide(velocity)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Set anim
	if velocity != Vector2(0, 0):
		if isMoving == false:
			animState.travel('Walk')
			isMoving = true
		animTree.set('parameters/Walk/blend_position', velocity)
		animTree.set('parameters/Idle/blend_position', velocity)
	else:
		if isMoving == true:
			animState.travel('Idle')
			isMoving = false

	# Define velocity
	velocity = velocity.normalized() * speed
