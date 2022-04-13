extends Control

onready var chatLog = get_node("ChatContainer/ChatBox")
onready var inputLabel = get_node("ChatContainer/EditContainer/Label")
onready var inputField = get_node("ChatContainer/EditContainer/LineEdit")

var categories = {
	'Say': '#00abc7',
	'Group': '#ffffff',
	'Global': '#FFF113'
}

var catKey = 'Say' 
var user_name = 'Player'

func _ready():
	inputField.connect("text_entered", self,'text_entered')
	catKey = 'Say'

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()
		if event.pressed and event.scancode == KEY_TAB:
			change_group()

func change_group():

	if catKey == 'Say':
		catKey = 'Group'
	else:
		catKey = 'Say'

	inputLabel.text = '[' + categories[catKey]['name'] + ']'
	inputLabel.set("custom_colors/font_color", Color(categories[catKey]['color']))
	
func add_message(username, text, category = '', color = ''):
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


func text_entered(text):
	if text =='/h':
		add_message('', 'There is no help message yet!', 'Say')
		inputField.text = ''		
		return
	if text != '':
		add_message(user_name, text)
		# Here you have to send the message to the server
		print(text)
		inputField.text = ''
