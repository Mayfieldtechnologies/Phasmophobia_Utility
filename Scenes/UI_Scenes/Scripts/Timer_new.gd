extends Control
#startlines: 306
#endlines: 225

# Time measured in seconds

# Get Timer
@onready var CountdownTimer = $timerCountdown
var timeCompare

# Timer Default Time
@export var timeStart = 180.0

# Ghost Timers
# Dev: Need to switch this up to use a time elapsed instead.
# This would make Demon: 30, Standard: 90, Spirit: 180

@onready var dictGhosts = {
	"Demon": 120,
	"Standard": 90,
	"Spirit": 0
}

# Misc Variables
var currGhost
var currBreakpoint
var currTime
#var timer_started = false
var bypassPause = false

# Current Time Variables
@onready var currMin : int = timeStart / 60
var currSecond : int = 0
var currMS : int = 0
var currTimeString: String = ""

# Node References
@onready var BeginPlaceholder = $BeginPlaceholder
@onready var SpiritPlaceholder = $SpiritPlaceholder
@onready var NodeTimeIndicator = $NodeTimeIndicator
@onready var NodeTimeCurrent = $NodeTimeIndicator/TimeCurrent
@onready var NodeStartButton = $StartButton
@onready var NodeGhostTimerEnded = $GhostTimerEnded

var main_scene

# Sound
@onready var TimerAudio = $TimerAudio	
@onready var UIAudio = $UIAudio

# Ghosts
@onready var count_demon_start = preload("res://Sounds/Timer/demon_timer_ending_in.mp3")
@onready var count_standard_start = preload("res://Sounds/Timer/standard_timer_ending_in.mp3")
@onready var count_spirit_start = preload("res://Sounds/Timer/spirit_timer_ending_in.mp3")

# Countdowns
@onready var count_10 = preload("res://Sounds/Timer/10.mp3")
@onready var count_5 = preload("res://Sounds/Timer/5.mp3")
@onready var count_4 = preload("res://Sounds/Timer/4.mp3")
@onready var count_3 = preload("res://Sounds/Timer/3.mp3")
@onready var count_2 = preload("res://Sounds/Timer/2.mp3")
@onready var count_1 = preload("res://Sounds/Timer/1.mp3")
@onready var toggle_on = preload("res://Sounds/UI/Toggle-on.mp3")
@onready var toggle_off = preload("res://Sounds/UI/Toggle-off.mp3")

@onready var dictSounds = {
	"start_Demon": count_demon_start,
	"start_Standard": count_standard_start,
	"start_Spirit": count_spirit_start,
	"count_10": count_10,
	"count_5": count_5,
	"count_4": count_4,
	"count_3": count_3,
	"count_2": count_2,
	"count_1": count_1	
}

@onready var time_bar = $TimeBar
@onready var bg_default = preload("res://Scenes/UI_Scenes/Resources/Smudge/smudge_background_default.tres")
@onready var bg_demon = preload("res://Scenes/UI_Scenes/Resources/Smudge/smudge_background_demon.tres")
@onready var bg_standard = preload("res://Scenes/UI_Scenes/Resources/Smudge/smudge_background_standard.tres")
@onready var bg_spirit = preload("res://Scenes/UI_Scenes/Resources/Smudge/smudge_background_spirit.tres")

var xStart # Start is on the right side
var xEnd # End is on the left side

var TotalDistance

func _ready():
	main_scene = find_parental(self,"Main")
	reset_timer()
	reset_indicator()
	reset_ghost_reference()
	define_placeholders()
	time_bar.add_theme_stylebox_override("panel",bg_default)

func _process(_delta):
	if CountdownTimer.is_stopped() == false:
		
		timeCompare = currTime
		currTime = CountdownTimer.time_left
		
		if floor(timeCompare) != floor(currTime):
			checkTime(floor(currTime))
		
		update_time_indicator(currTime)
	
func define_placeholders():
	xStart = BeginPlaceholder.global_position.x
	xEnd = SpiritPlaceholder.global_position.x
	
	TotalDistance = xStart - xEnd

func play_audio(audio_file):
	UIAudio.stream = audio_file
	UIAudio.play()

func update_time_indicator(currTime):
	NodeTimeIndicator.global_position.x = xEnd + (currTime/timeStart)*TotalDistance
	UpdateTimeString(currTime)

func checkTime(currCheck):
	print("checkTime received: " + str(currCheck) + " with a breakpoint of " + str(currBreakpoint))
	if currCheck == currBreakpoint + 12:
		play_audio(dictSounds["start_"+currGhost])
	elif currCheck == currBreakpoint + 10:
		play_audio(count_10)
	elif currCheck == currBreakpoint + 5:
		play_audio(count_5)
	elif currCheck == currBreakpoint + 4:
		play_audio(count_4)
	elif currCheck == currBreakpoint + 3:
		play_audio(count_3)
	elif currCheck == currBreakpoint + 2:
		play_audio(count_2)
	elif currCheck == currBreakpoint + 1:
		play_audio(count_1)
	elif currCheck == currBreakpoint:
			NodeGhostTimerEnded.text = currGhost + " Timer Ended"
			
			if currGhost == "Demon":
				set_override(bg_demon)
				currGhost = "Standard"
			elif currGhost == "Standard":
				set_override(bg_standard)
				currGhost = "Spirit"
			elif currGhost == "Spirit":
				set_override(bg_spirit)
			else:
				return
				
			currBreakpoint = dictGhosts[currGhost]

func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))

func UpdateTimeString(seconds):
	NodeTimeCurrent.text = format_seconds_to_string(seconds)

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

func set_override(theme: StyleBoxFlat):
	time_bar.add_theme_stylebox_override("panel",theme)

func _on_timer_countdown_timeout():
	toggle_timer(false)

func stop_timer():
	CountdownTimer.stop()
	NodeStartButton.toggle_button_state(false)
	play_audio(toggle_off)

func reset_timer():
	CountdownTimer.wait_time = timeStart	
	
func start_timer():
	CountdownTimer.start()
	NodeStartButton.toggle_button_state(true)
	play_audio(toggle_on)

func reset_indicator():
	NodeTimeIndicator.global_position.x = BeginPlaceholder.global_position.x
	currTime = timeStart

func reset_ghost_reference():
	# Reset Ghost Reference
	currGhost = "Demon"
	currBreakpoint = dictGhosts[currGhost]
	NodeGhostTimerEnded.text = ""
	
	# Set bar color back to default
	set_override(bg_default)

func _on_button_pressed():
	if(CountdownTimer.is_stopped()):
		toggle_timer(true)
	else:
		toggle_timer(false)

func toggle_timer(toggle_on: bool):
	if toggle_on:
		reset_timer()
		reset_indicator()
		reset_ghost_reference()
		start_timer()
		bypassPause = main_scene.get_bypass_smudge_pause()
	else:
		stop_timer()
