extends KinematicBody2D

signal playerIsMoving
signal playerStoppedMoving

var state = 0b00

export (int)var speed = 300
export var jumpSpeed = 400
var newPos = Vector2()
var canMove = true

onready var isMoving = false
onready var animTree = $playerAnimTree
onready var animState = animTree.get('parameters/playback')
onready var cooldown = $Cooldown
var canShoot = true
var velocity = Vector2.ZERO

onready var ballScene = preload("res://Scenes/Entities/Ball.tscn")

var jumpOverLedge: bool = false
var direction = Vector2.DOWN

func _ready():
	animState.start('Idle')

func setMovement(_bool):
	canMove = _bool

func _physics_process(_delta):
	if canMove:
		get_input()
		setAnim()
		move_and_slide(velocity*speed)


func setAnim():
	# Set anim
	if velocity != Vector2(0, 0):
		if isMoving == false:
			animState.travel('Walk')
			emit_signal("playerIsMoving")
			isMoving = true
		animTree.set('parameters/Walk/blend_position', velocity)
		animTree.set('parameters/Idle/blend_position', velocity)
		direction = velocity
	else:
		if isMoving == true:
			animState.travel('Idle')
			emit_signal("playerStoppedMoving")
			isMoving = false


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
	
	if Input.is_action_pressed("shoot"):
		fire()


func fire():
	if canShoot:
		var _ball = ballScene.instance()
		_ball.position = position
		_ball.direction = get_global_mouse_position() - global_position
		get_parent().add_child(_ball)
		canShoot = false
		cooldown.start()


func _on_Cooldown_timeout():
	canShoot = true
