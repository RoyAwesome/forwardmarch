class_name GameScene
extends Node

@onready var BoardPanel : PanelContainer = %BoardPanel
@onready var ButtonGrid : PanelContainer = %ButtonGrid

@onready var WaveTimer : Timer = %WaveTimer
var CurrentWave : int = 0
var Team1 : Team
var Team2 : Team

var WaveQueue : Array[Wave]

var TeamDisplays : Array[TeamDisplay]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TeamDisplays = [%Team1Display, %Team2Display]
	
	# generate a force for each player
	Team1 = Team.new([0, 1, 2])
	Team2 = Team.new([3, 4, 5])
	for i in 3:
		WaveQueue.push_back(Wave.new(Team1.Forces[i % Team1.Forces.size()], Team2.Forces[i % Team2.Forces.size()]))	
	
	for i in TeamDisplays.size():		
		TeamDisplays[i].AssignedTeam = Team1 if i%2 == 0 else Team2
	
	WaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_board_panel_button_toggled(toggled_on: bool) -> void:
	BoardPanel.visible = toggled_on
	%BoardButton.button_pressed = toggled_on # Toggle on the board when you open the board panel

func _on_board_button_toggled(toggled_on: bool, button_index: int) -> void:
	var buttons : Array = [%BoardButton, %BaseButton, %UnitsButton, %UpgradeButton, %ItemButton, %ViewButton]
	ButtonGrid.visible = !toggled_on if button_index == 0 else toggled_on

func timer_for_force(force : Force) -> int:
	for wave in WaveQueue.size():
		if(WaveQueue[wave].ForceLeft == force || WaveQueue[wave].ForceRight == force):
			return WaveTimer.time_left + (WaveTimer.wait_time * wave)
	return -1
	
func timer_for_wave(wave : Wave) -> int:
	for w in WaveQueue.size():
		if(WaveQueue[w] == wave):
			return WaveTimer.time_left + (WaveTimer.wait_time * w)
	return -1

func _on_wave_timer_timeout() -> void:
	# Spawn those player's waves
	
	var active_wave : Wave = WaveQueue.pop_front()
	# Spawn the wave
	# ......
	
	# Generate the next wave
	var NewWave : Wave = Wave.new(Team1.Forces[CurrentWave % Team1.Forces.size()], Team2.Forces[CurrentWave % Team2.Forces.size()])
	WaveQueue.push_back(NewWave)	
	CurrentWave += 1
	
