extends Control

signal takeFocus(_bool)
signal messageSig(message)

onready var chatLog = get_node('ChatContainer/ChatBox')
onready var inputLabel = get_node('ChatContainer/EditContainer/Label')
onready var inputField = get_node('ChatContainer/EditContainer/LineEdit')

var channels = {
	'Say': '#ffffff',
	'Group': '#00abc7',
	'Global': '#FFF113'
}

var catKey = 'Say' 
var userName = 'Player'
var focusState = false


func _ready():
	
	inputField.connect("text_entered", self,'textEntered')
	catKey = 'Say'
	
	inputField.connect("focus_entered", self, "focusIn")
	inputField.connect("focus_exited", self, "focusOut")


func changeFocus(_bool):
	"""
	Give/return the focus to the inputField and emit a signal
	"""
	focusState = _bool
	setPlayerMovement(!_bool)
	if _bool:
		inputField.grab_focus()
	else:
		inputField.release_focus()


func focusIn():
	changeFocus(true)
	
	
func focusOut():
	changeFocus(false)


func setPlayerMovement(_bool):
	emit_signal("takeFocus", _bool)


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			if focusState:
				textEntered(inputField.text)
			changeFocus(!focusState)
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
	
	
