extends Node

onready var chat = get_node('/root/Node2D/CanvasLayer/Chat')
onready var player = $FlyNavigation/WalkNavigation/YSort/Player
onready var server = get_node('/root/Server')


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Connect Chat signals
	chat.connect('takeFocus', player, 'setMovement')
	chat.connect('messageSig', server, 'sendChatMessage')
	# connect Server signals
	server.connect('messageReceivedSig', chat, 'addMessage')


