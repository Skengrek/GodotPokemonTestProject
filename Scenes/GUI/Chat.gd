extends Control

signal takeFocus(_bool)
signal messageSig(message)

onready var chatLog = get_node('ChatContainer/ChatBox')
onready var inputLabel = get_node('ChatContainer/EditContainer/Label')
onready var inputField = get_node('ChatContainer/EditContainer/LineEdit')

onready var server = get_node('/root/Server')

var channels = {
	'Say': '#ffffff',
	'Group': '#00abc7',
	'Global': '#FFF113'
}

var catKey = 'Say' 
var user_name = 'Player'


func _ready():
	
	inputField.connect("text_entered", self,'textEntered')
	catKey = 'Say'


func changeFocus(_bool):
	"""
	Give/return the focus to the inputField and emit a signal
	"""
	setPlayerMovement(!_bool)
	if _bool:
		inputField.grab_focus()
	else:
		inputField.release_focus()


func setPlayerMovement(_bool):
	emit_signal("takeFocus", _bool)


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			changeFocus(true)
		if event.pressed and event.scancode == KEY_ESCAPE:
			changeFocus(false)
		if event.pressed and event.scancode == KEY_TAB:
			change_group()


func change_group():
	if catKey == 'Say':
		catKey = 'Group'
	else:
		catKey = 'Say'

	inputLabel.text = '[' + catKey + ']'
	inputLabel.set("custom_colors/font_color", Color(channels[catKey]))
	
	
func addMessage(username, text, channel = '', color = ''):
	if channel == '':
		channel = catKey
	chatLog.bbcode_text += '' 
	if color == '':
		chatLog.bbcode_text += '[color=' + channels[channel] + ']'
	else:
		chatLog.bbcode_text += '[color=' + color + ']'
	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]\n'
	

func textEntered(text):
	if text != '':
		changeFocus(true)
		inputField.text = ''
		emit_signal('messageSig', text)
	
	
