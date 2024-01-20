extends Control
# Time measured in seconds

# Get Timer
@onready var CountdownTimer = $timerCountdown
var timeCompare

# Timer Start
var timeStart = 25

# Misc Variables
var currTime
var startTimer = false
var bypassPause = false

# Current Time Variables
@onready var currMin : int = timeStart / 60
var currSecond : int = 0
var currMS : int = 0
var currTimeString: String = ""

# Node References
@onready var BeginPlaceholder = $BeginPlaceholder
@onready var EndPlaceholder = $StandardPlaceholder
@onready var NodeTimeIndicator = $NodeTimeIndicator
@onready var NodeTimeCurrent = $NodeTimeIndicator/TimeCurrent
@onready var NodeStartButton = $StartButton

var main_scene

# Sound
@onready var TimerAudio = $TimerAudio

# Ghosts
@onready var count_hunt_start = preload("res://Sounds/Timer/hunt_timer_ending_in.mp3")

# Countdowns
@onready var count_3 = preload("res://Sounds/Timer/hunt_timer_3.mp3")
@onready var count_2 = preload("res://Sounds/Timer/hunt_timer_2.mp3")
@onready var count_1 = preload("res://Sounds/Timer/hunt_timer_1.mp3")

@onready var dictSounds = {
	"start_Hunt": count_hunt_start,
	"count_3": count_3,
	"count_2": count_2,
	"count_1": count_1	
}

var xStart # Start is on the right side
var xEnd # End is on the left side

var TotalDistance

func _ready():
	main_scene = find_parental(self,"Main")
	CountdownTimer.wait_time = timeStart
	define_placeholders()

func define_placeholders():
	xStart = BeginPlaceholder.global_position.x
	xEnd = EndPlaceholder.global_position.x
	
	TotalDistance = xStart - xEnd

func toggle_timer():
	startTimer = !startTimer
	if startTimer == true or bypassPause:
		ResetTimer()
	else:
		NodeStartButton.text = "Start Timer"

func _on_button_pressed():
	#bypassPause = main_scene.get_bypass_smudge_pause()
	#print(bypassPause)
	CountdownTimer.start()
	toggle_timer()

func _process(_delta):
	if startTimer == true:
		
		timeCompare = currTime
		currTime = CountdownTimer.time_left
		
		if int(timeCompare) != int(currTime):
			checkTime(int(currTime)+1)
		
		if currTime > 0:
			NodeTimeIndicator.global_position.x = xEnd + (currTime/timeStart)*TotalDistance
	
		UpdateTimeString()
		

func checkTime(currCheck):
	if currCheck == 5:
		TimerAudio.stream = count_hunt_start
		TimerAudio.play()
	elif currCheck == 3:
		TimerAudio.stream = count_3
		TimerAudio.play()
	elif currCheck == 2:
		TimerAudio.stream = count_2
		TimerAudio.play()
	elif currCheck == 1:
		TimerAudio.stream = count_1
		TimerAudio.play()

func UpdateTimeString():
	# Parse Min, Sec, MS from seconds
	currMin = abs(int(currTime / 60))
	currSecond = abs(int(currTime) % 60)
	currMS = abs(int((currTime - int(currTime)) * 1000))
	
	var negativestring = ""
	if currTime < 0:
		negativestring = "- "
	
	currTimeString = negativestring + str(currMin).pad_zeros(1) + ":" + str(currSecond).pad_zeros(2) + ":" + str(currMS).left(2)
	
	NodeTimeCurrent.text = currTimeString

func ResetTimer():
	# Reset Time Indicator
	NodeTimeIndicator.position.x = xStart
	
	# Reset currTime
	currTime = timeStart
	
	# Reset Labels
	NodeStartButton.text = "Stop Timer"
	
	# Tell the process function that we've started the timer
	# Useful for the bypass timer pause
	startTimer = true
	
func _on_dev_test_sound_pressed():
	TimerAudio.stream = count_hunt_start
	TimerAudio.play()

func find_parental(current_node, target_node):
	# Check if current_node is the target_node
	if(current_node.name == target_node):
		return current_node
	
	# Define parent_node of current_node
	var parent_node = current_node.get_parent()
	
	# Check if parent_node is defined
	if parent_node:
		# Recursively run this function and store value in result
		var result = find_parental(parent_node, target_node)
		
		# Return the parent_node as the result if it is defined.
		if result:
			return result

func _on_timer_countdown_timeout():
	toggle_timer()
