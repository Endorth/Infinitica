extends Control


onready var curr_usernum_lab = $CurrentUserNumberLab
onready var curr_username_lab = $CurrentUserNameLab
onready var num_shadow_lab = $NumberShadow
onready var curr_num_lab = $Number

onready var record_number_lab = $RecordUserNumberLab
onready var accumulated_number_lab = $RecordNumberLab
onready var record_user_lab = $RecordUserLab


var player_list = []


var is_game_start : bool = false

var record_user : String = 'endorth4'
var record_number : int = 0

var accumulated_number : int = 0

var last_user : String = ''
var last_number : int = 0

var main_user_lab_pos : Vector2 = Vector2(20, 512)
var main_numb_lab_pos : Vector2 = Vector2(396, 512)
var shame_user_lab_pos : Vector2 = Vector2(144, 448)
var shame_numb_lab_pos : Vector2 = Vector2(156, 512)


func _ready():
	record_number_lab.text = str(record_number)
	record_user_lab.text = record_user
	curr_username_lab.rect_position = main_user_lab_pos
	curr_usernum_lab.rect_position = main_numb_lab_pos
	
	TwitchChat.connect("new_message", self, "send_data")

func send_data(data):
	if "username" in data:
		var user = data["username"]
		var msg = data["msg"]
		if msg.begins_with("-"):
			add_number(user, msg)

func add_number(plyr, msg):
	var value : int = 0
	value = int(msg)
	if plyr != last_user:
		if is_correct_number(value):
			update_number(plyr, value)
		else:
			restart_game(plyr)

func update_number(plyr, value):
	curr_username_lab.rect_position = main_user_lab_pos
	curr_usernum_lab.rect_position = main_numb_lab_pos
	last_number = value
	last_user = plyr

	curr_num_lab.text = str(value)
	num_shadow_lab.text = curr_num_lab.text
	
	curr_username_lab.text = str(plyr)
	curr_usernum_lab.text = str(value)
	
	accumulated_number -= 1
	accumulated_number_lab.text = str(accumulated_number)
	
	if record_number > value:
		record_number = value 
		if record_user != plyr:
			record_user = plyr
	
	update_record(record_user, record_number)
		
		
func restart_game(plyr):

	curr_username_lab.rect_position = shame_user_lab_pos
	curr_usernum_lab.rect_position = shame_numb_lab_pos
	
	last_number = 0
	last_user = ''

	curr_num_lab.text = str(0)
	num_shadow_lab.text = curr_num_lab.text
	
	curr_username_lab.text = "Shame on "
	curr_usernum_lab.text = str(plyr)

func update_record(p, v):
	record_number_lab.text = str(v)
	record_user_lab.text = p 

func is_correct_number(v) -> bool:
	return (v == last_number - 1)



