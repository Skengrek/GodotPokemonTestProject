extends Control

onready var chatLog = get_node("ChatContainer/ChatBox")
onready var inputLabel = get_node("ChatContainer/EditContainer/Label")
onready var inputField = get_node("ChatContainer/EditContainer/LineEdit")
onready var player = get_node("/root/Node2D/Player")

var categories = {
	'Say': '#ffffff',
	'Group': '#00abc7',
	'Global': '#FFF113'
}

var catKey = 'Say' 
var user_name = 'Player'

func _ready():
	inputField.connect("text_entered", self,'textEntered')
	catKey = 'Say'


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus()
			player.setMovement(false)
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()
			player.setMovement(true)
		if event.pressed and event.scancode == KEY_TAB:
			change_group()

func change_group():

	if catKey == 'Say':
		catKey = 'Group'
	else:
		catKey = 'Say'

	inputLabel.text = '[' + catKey + ']'
	inputLabel.set("custom_colors/font_color", Color(categories[catKey]))
	
func addMessage(username, text, category = '', color = ''):
	if category == '':
		category = catKey

	chatLog.bbcode_text += '\n' 
	if color == '':
		chatLog.bbcode_text += '[color=' + categories[category] + ']'
	else:
		chatLog.bbcode_text += '[color=' + color + ']'
	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'


func textEntered(text):
	if text != '':
		player.setMovement(true)
		inputField.text = ''
		# Send message to server
		rpc_id(1, "addMessageToChat", text)
		# Finally
		inputField.release_focus()
	
	
