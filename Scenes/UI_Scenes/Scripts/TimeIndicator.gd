extends Control

# Time measured in seconds

# Framerate (want to replace with user-selectable at some point)
var framerate = 144.0

# Coordinate Configuration
var xStart = 218.0
var xEnd = 25.0
@onready var TotalDistance = xStart - xEnd

# Frame Calculation
var timeStart = 180.0
@onready var TotalFrames = timeStart * framerate
@onready var DistancePerFrame = TotalDistance / TotalFrames

# Demon Configuration
var timeDemon = 120.0
@onready var frameDemon = TotalFrames - (timeDemon * framerate)
@onready var xDemon = xStart - frameDemon * DistancePerFrame

@onready var frameDemonWarn_Start = TotalFrames - ((timeDemon + 12) * framerate)
@onready var frameDemonWarn_10 = TotalFrames - ((timeDemon + 10) * framerate)
@onready var frameDemonWarn_5 = TotalFrames - ((timeDemon+5) * framerate)
@onready var frameDemonWarn_4 = TotalFrames - ((timeDemon+4) * framerate)
@onready var frameDemonWarn_3 = TotalFrames - ((timeDemon+3) * framerate)
@onready var frameDemonWarn_2 = TotalFrames - ((timeDemon+2) * framerate)
@onready var frameDemonWarn_1 = TotalFrames - ((timeDemon+1) * framerate)

# Standard Configuratiohn
var timeStandard = 90.0
@onready var frameStandard = TotalFrames - (timeStandard * framerate)
@onready var xStandard = xStart - frameStandard * DistancePerFrame

@onready var frameStandardWarn_Start = TotalFrames - ((timeStandard + 12) * framerate)
@onready var frameStandardWarn_10 = TotalFrames - ((timeStandard + 10) * framerate)
@onready var frameStandardWarn_5 = TotalFrames - ((timeStandard+5) * framerate)
@onready var frameStandardWarn_4 = TotalFrames - ((timeStandard+4) * framerate)
@onready var frameStandardWarn_3 = TotalFrames - ((timeStandard+3) * framerate)
@onready var frameStandardWarn_2 = TotalFrames - ((timeStandard+2) * framerate)
@onready var frameStandardWarn_1 = TotalFrames - ((timeStandard+1) * framerate)

# Spirit Configuration
var timeSpirit = 0.0
@onready var frameSpirit = TotalFrames - (timeSpirit * framerate)
var xSpirit = xEnd

@onready var frameSpiritWarn_Start = TotalFrames - ((timeSpirit + 12) * framerate)
@onready var frameSpiritWarn_10 = TotalFrames - ((timeSpirit + 10) * framerate)
@onready var frameSpiritWarn_5 = TotalFrames - ((timeSpirit+5) * framerate)
@onready var frameSpiritWarn_4 = TotalFrames - ((timeSpirit+4) * framerate)
@onready var frameSpiritWarn_3 = TotalFrames - ((timeSpirit+3) * framerate)
@onready var frameSpiritWarn_2 = TotalFrames - ((timeSpirit+2) * framerate)
@onready var frameSpiritWarn_1 = TotalFrames - ((timeSpirit+1) * framerate)

# Misc Variables
var currFrame = 0
var currTime = timeStart
var timeElapsed = 0
var startTimer = false

# Current Time Variables
@onready var currMin : int = timeStart / 60
var currSecond : int = 0
var currMS : int = 0
var currTimeString: String = ""

# Node References
@onready var NodeTimeIndicator = get_node("NodeTimeIndicator")
@onready var NodeTimeCurrent = get_node("NodeTimeIndicator/TimeCurrent")
@onready var NodeStartButton = get_node("StartButton")
@onready var NodeGhostTimerEnded = get_node("GhostTimerEnded")

# Sound
@onready var TimerAudio = $TimerAudio	

@onready var count_demon_start = preload("res://Sounds/Timer/demon_timer_ending_in.mp3")
@onready var count_standard_start = preload("res://Sounds/Timer/standard_timer_ending_in.mp3")
@onready var count_spirit_start = preload("res://Sounds/Timer/spirit_timer_ending_in.mp3")


@onready var count_10 = preload("res://Sounds/Timer/10.mp3")
@onready var count_5 = preload("res://Sounds/Timer/5.mp3")
@onready var count_4 = preload("res://Sounds/Timer/4.mp3")
@onready var count_3 = preload("res://Sounds/Timer/3.mp3")
@onready var count_2 = preload("res://Sounds/Timer/2.mp3")
@onready var count_1 = preload("res://Sounds/Timer/1.mp3")



func _on_button_pressed():
	startTimer = !startTimer
	if startTimer == true:
		NodeTimeIndicator.position.x = xStart
		currTime = timeStart
		currFrame = 0
		NodeStartButton.text = "Stop Timer"
		NodeGhostTimerEnded.text = ""
	else:
		NodeStartButton.text = "Start Timer"

func _process(delta):
	if startTimer == true:
		currFrame += 1.0

		timeElapsed = currFrame / framerate
		currTime = timeStart - timeElapsed
		
		currMin = abs(int(currTime / 60))
		currSecond = abs(int(currTime) % 60)
		currMS = abs(int((currTime - int(currTime)) * 1000))
		
		var negativestring = ""
		if currTime < 0:
			negativestring = "- "
		
		currTimeString = negativestring + str(currMin).pad_zeros(1) + ":" + str(currSecond).pad_zeros(2) + ":" + str(currMS).left(2)
		
		
		NodeTimeCurrent.text = currTimeString
		
		#print(str(NodeTimeIndicator.global_position.x))
		if currFrame < frameSpirit:
			NodeTimeIndicator.global_position.x -= DistancePerFrame
			#print(NodeTimeIndicator.global_position.x)
		
		match currFrame:
			frameDemonWarn_Start:
				TimerAudio.stream = count_demon_start
				TimerAudio.play()
			frameDemonWarn_10:
				TimerAudio.stream = count_10
				TimerAudio.play()
			frameDemonWarn_5:
				TimerAudio.stream = count_5
				TimerAudio.play()
			frameDemonWarn_4:
				TimerAudio.stream = count_4
				TimerAudio.play()
			frameDemonWarn_3:
				TimerAudio.stream = count_3
				TimerAudio.play()
			frameDemonWarn_2:
				TimerAudio.stream = count_2
				TimerAudio.play()
			frameDemonWarn_1:
				TimerAudio.stream = count_1
				TimerAudio.play()
			frameStandardWarn_Start:
				TimerAudio.stream = count_standard_start
				TimerAudio.play()
			frameStandardWarn_10:
				TimerAudio.stream = count_10
				TimerAudio.play()
			frameStandardWarn_5:
				TimerAudio.stream = count_5
				TimerAudio.play()
			frameStandardWarn_4:
				TimerAudio.stream = count_4
				TimerAudio.play()
			frameStandardWarn_3:
				TimerAudio.stream = count_3
				TimerAudio.play()
			frameStandardWarn_2:
				TimerAudio.stream = count_2
				TimerAudio.play()
			frameStandardWarn_1:
				TimerAudio.stream = count_1
				TimerAudio.play()
			frameSpiritWarn_Start:
				TimerAudio.stream = count_spirit_start
				TimerAudio.play()
			frameSpiritWarn_10:
				TimerAudio.stream = count_10
				TimerAudio.play()
			frameSpiritWarn_5:
				TimerAudio.stream = count_5
				TimerAudio.play()
			frameSpiritWarn_4:
				TimerAudio.stream = count_4
				TimerAudio.play()
			frameSpiritWarn_3:
				TimerAudio.stream = count_3
				TimerAudio.play()
			frameSpiritWarn_2:
				TimerAudio.stream = count_2
				TimerAudio.play()
			frameSpiritWarn_1:
				TimerAudio.stream = count_1
				TimerAudio.play()
			frameDemon:
				NodeGhostTimerEnded.text = "Demon Timer Ended"
			frameStandard:
				NodeGhostTimerEnded.text = "Standard Timer Ended"
			frameSpirit:
				NodeGhostTimerEnded.text = "Spirit Timer Ended"
