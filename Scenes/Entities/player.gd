extends KinematicBody2D

signal playerIsMoving
signal playerStoppedMoving

export (int)var speed = 8
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
var jumpOverLedge: bool = false

func _ready():
	animState.start('Idle')

func setMovement(_bool):
	canMove = _bool

func _physics_process(_delta):
	if canMove:
		var inputProcessed = get_input()
		newPos = global_position + inputProcessed * speed
		# Cast raycast
		ledgeRayCast.cast_to = inputProcessed * speed * 4
		blockRayCast.cast_to = inputProcessed * speed * 4
		if inputProcessed != Vector2(0, 0):
			print(newPos-global_position)
			print(blockRayCast.is_colliding())
		
		if is_instance_valid(nextPositionOverlay):
			nextPositionOverlay.queue_free()
		nextPositionOverlay = TextureRect.new()
		nextPositionOverlay.texture = nextPositionTexture
		nextPositionOverlay.rect_scale = Vector2(2, 2)
		nextPositionOverlay.rect_position = newPos
		get_tree().current_scene.add_child(nextPositionOverlay)
		
#		var goingBot = (velocity.y - velocityMemory.y)>0 and (velocity.x+velocityMemory.x)==0
#		if (ledgeRayCast.is_colliding()) and goingBot:
#			# Jump over ledge
#			jumpOverLedge = true
#			velocity = velocity.normalized() * jumpSpeed
#			velocity = move_and_slide(velocity)
#		if not blockRayCast.is_colliding():
		global_position = newPos

func get_input():
	
	var input = Vector2()
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_up"):
		input.y -= 1

	# Set anim
	if input != Vector2(0, 0):
		if isMoving == false:
			animState.travel('Walk')
			emit_signal("playerIsMoving")
			isMoving = true
		animTree.set('parameters/Walk/blend_position', input)
		animTree.set('parameters/Idle/blend_position', input)
	else:
		if isMoving == true:
			animState.travel('Idle')
			emit_signal("playerStoppedMoving")
			isMoving = false

	return input

