extends KinematicBody2D

signal playerIsMoving
signal playerStoppedMoving

export (int)var speed = 4
export var jumpSpeed = 200
var newPos = Vector2()
var canMove = true
const nextPositionTexture = preload("res://Assets/UI/ui_arrow_left_right.png")
var nextPositionOverlay: TextureRect = null

onready var isMoving = false
onready var animTree = $playerAnimTree
onready var animState = animTree.get('parameters/playback')
onready var ledgeRayCast = $LedgeRayCast
onready var blockRayCast = $BlockingRayCast
onready var cooldown = $Cooldown
var canShoot = true

onready var ballScene = preload("res://Scenes/Entities/Ball.tscn")

var jumpOverLedge: bool = false
var direction = Vector2.DOWN

func _ready():
	animState.start('Idle')

func setMovement(_bool):
	canMove = _bool

func _physics_process(delta):
	if canMove:
		var inputProcessed = get_input(delta)
		setAnim(inputProcessed)
		newPos = global_position + inputProcessed * speed
		# Cast raycast
		ledgeRayCast.global_position = global_position
		blockRayCast.global_position = global_position
		ledgeRayCast.cast_to = inputProcessed * speed * 4
		blockRayCast.cast_to = inputProcessed * speed * 4 
			
		if not blockRayCast.is_colliding():
			global_position = newPos
		else:
			if ledgeRayCast.is_colliding() and inputProcessed==Vector2(0, 1):
				global_position = newPos
			else:
				global_position = global_position - inputProcessed


func setAnim(input):
	# Set anim
	if input != Vector2(0, 0):
		if isMoving == false:
			animState.travel('Walk')
			emit_signal("playerIsMoving")
			isMoving = true
		animTree.set('parameters/Walk/blend_position', input)
		animTree.set('parameters/Idle/blend_position', input)
		direction = input
	else:
		if isMoving == true:
			animState.travel('Idle')
			emit_signal("playerStoppedMoving")
			isMoving = false


func get_input(_delta):
	var input = Vector2()
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	elif Input.is_action_pressed("ui_left"):
		input.x -= 1
	elif Input.is_action_pressed("ui_down"):
		input.y += 1
	elif Input.is_action_pressed("ui_up"):
		input.y -= 1
	
	if Input.is_action_pressed("shoot"):
		fire()
		
	return input


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
