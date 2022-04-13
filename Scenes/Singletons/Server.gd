extends Node

var network = NetworkedMultiplayerENet.new()
var ip = '127.0.0.1'
var port = 1909

var fakeConnection = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if fakeConnection:
		connectToServer()


func connectToServer():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)

	network.connect('connection_failed', self, '_OnConnectionFailed')
	network.connect('connection_succeeded', self, '_OnConnectionSucceeded')


func _OnConnectionFailed():
	print('Failed Connection to server')


func _OnConnectionSucceeded():
	print('Connected to server')
