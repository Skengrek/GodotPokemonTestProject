extends Node2D

onready var animPlayer = $AnimationPlayer
const grassOverlayTexture = preload("res://Assets/Grass/stepped_tall_grass.png")
var grassOverlay: TextureRect = null
var playerInside: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.find_node("Player").connect(
		"playerIsMoving", self, "playerExitingGrass"
	)
	get_tree().current_scene.find_node("Player").connect(
		"playerStoppedMoving", self, "playerEnteredGrass"
	)
	

func _on_Area2D_body_entered(_body):
	animPlayer.play("stepped")
	playerInside = true


func playerExitingGrass():
	if is_instance_valid(grassOverlay):
		grassOverlay.queue_free()


func playerEnteredGrass():
	if playerInside:
		grassOverlay = TextureRect.new()
		grassOverlay.texture = grassOverlayTexture
		grassOverlay.rect_scale = Vector2(2, 2)
		grassOverlay.rect_position = global_position
		get_tree().current_scene.add_child(grassOverlay)


func _on_Area2D_body_exited(body):
	playerInside = false # Replace with function body.
