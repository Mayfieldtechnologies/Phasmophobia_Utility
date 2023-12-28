extends Control
# Time measured in seconds

# Get Timer
@onready var CountdownTimer = $timerCountdown
var timeCompare

# Frame Calculation
var timeStart = 180.0

# Ghost Spawn Dictionary
# Demon: 120
# Ghost: 90
# Spirit: 0

@onready var dictGhosts = {
	"Demon": 120,
	"Standard": 90,
	"Spiri6t": 0
}

# Misc Variables
var currGhost
var currBreakpoint
var currTime
var startTimer = false
var MasterVolume = 50.0

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
@onready var VolumeString = $VolumeSlider/VolumeString

# Sound
@onready var TimerAudio = $TimerAudio	
@onready var VolumeSlider = $VolumeSlider

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

var xStart # Start is on the right side
var xEnd # End is on the left side

var TotalDistance

func _ready():
	CountdownTimer.wait_time = timeStart
	
	xStart = BeginPlaceholder.global_position.x
	xEnd = SpiritPlaceholder.global_position.x
	VolumeSlider.value = MasterVolume
	
	TotalDistance = xStart - xEnd
	

func _on_button_pressed():
	CountdownTimer.start()
	
	startTimer = !startTimer
	if startTimer == true:
		ResetTimer()
	else:
		NodeStartButton.text = "Start Timer"

func _process(_delta):
	if startTimer == true:
		
		timeCompare = currTime
		currTime = CountdownTimer.time_left
		
		if int(timeCompare) != int(currTime):
			checkTime(int(currTime)+1)
		
		UpdateTimeString()
		
		if currTime > 0:
			NodeTimeIndicator.global_position.x = xEnd + (currTime/timeStart)*TotalDistance
		
	print(TimerAudio.volume_db)
		
func checkTime(currCheck):
	if currCheck == currBreakpoint + 12:
		TimerAudio.stream = dictSounds["start_"+currGhost]
		TimerAudio.play()
	elif currCheck == currBreakpoint + 10:
		TimerAudio.stream = count_10
		TimerAudio.play()
	elif currCheck == currBreakpoint + 5:
		TimerAudio.stream = count_5
		TimerAudio.play()
	elif currCheck == currBreakpoint + 4:
		TimerAudio.stream = count_4
		TimerAudio.play()
	elif currCheck == currBreakpoint + 3:
		TimerAudio.stream = count_3
		TimerAudio.play()
	elif currCheck == currBreakpoint + 2:
		TimerAudio.stream = count_2
		TimerAudio.play()
	elif currCheck == currBreakpoint + 1:
		TimerAudio.stream = count_1
		TimerAudio.play()
	elif currCheck == currBreakpoint:
			print(currGhost + " Breakpoint")
			NodeGhostTimerEnded.text = currGhost + " Timer Ended"
			
			if currGhost == "Demon":
				currGhost = "Standard"
			elif currGhost == "Standard":
				currGhost = "Spirit"
			else:
				return
				
			currBreakpoint = dictGhosts[currGhost]

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
	NodeGhostTimerEnded.text = ""
	
	# Reset Ghost Reference
	currGhost = "Demon"
	currBreakpoint = dictGhosts[currGhost]

func get_master_volume():
	return MasterVolume/100

func _on_volume_slider_value_changed(value):
	var NewVolume = -24 + (value/100) * 48
	TimerAudio.volume_db = NewVolume
	VolumeString.text = str(value) + " %"
	MasterVolume = value


func _on_dev_test_sound_pressed():
	TimerAudio.stream = count_demon_start
	TimerAudio.play()
