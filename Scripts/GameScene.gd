class_name GameScene
extends Node

var UnitScene : PackedScene = preload("res://Scenes/Unit.tscn")
var BoardScene : PackedScene = preload("res://Scenes/Board.tscn")
var TestUnit : UnitResource = preload("res://Units/TestUnit.tres")

@onready var BoardPanel : PanelContainer = %BoardPanel
@onready var ButtonGrid : PanelContainer = %ButtonGrid
@onready var Battlefield : Battlefield = $UI/SubViewportContainer/SubViewport/Battlefield

@onready var WaveTimer : Timer = %WaveTimer
var CurrentWave : int = 0
var Team1 : Team
var Team2 : Team

var WaveQueue : Array[Wave]

var TeamDisplays : Array[TeamDisplay]
var AllForces : Array[Force]

var LocalPlayer : int = 0

var CurrentPlayerBoard : Board
var CurrentViewedBoard : Board

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TeamDisplays = [%Team1Display, %Team2Display]
	
	# generate a force for each player
	var PlayersIn1 : Array[Force]
	var PlayersIn2 : Array[Force]
	for i in 3:
		PlayersIn1.push_back(create_player_force(i))
		PlayersIn2.push_back(create_player_force(i + 3))
	Team1 = Team.new(PlayersIn1)
	Team2 = Team.new(PlayersIn1)
	for i in 3:
		WaveQueue.push_back(Wave.new(Team1.Forces[i % Team1.Forces.size()], Team2.Forces[i % Team2.Forces.size()]))	
	
	for i in TeamDisplays.size():		
		TeamDisplays[i].AssignedTeam = Team1 if i%2 == 0 else Team2
	
	WaveTimer.start()
	
	AllForces[LocalPlayer].OwningBoard.ready.connect(func (): 
		view_board(AllForces[LocalPlayer].OwningBoard))
	

func create_player_force(player_id : int) -> Force:
	var force : Force = Force.new(player_id, null)
	AllForces.insert(player_id, force)
	# create a board for the player
	var viewport = SubViewport.new()
	viewport.name = "Player %d" % player_id
	
	var PlayerBoard : Board = BoardScene.instantiate()
	PlayerBoard.name = "Player %d Board" % player_id
	PlayerBoard.OwningForce = force
	
	viewport.add_child.call_deferred(PlayerBoard)
	
	if(player_id == LocalPlayer):
		CurrentPlayerBoard = PlayerBoard
	get_tree().root.add_child.call_deferred(viewport)
	
	force.OwningBoard = PlayerBoard
	return force

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_current_player() -> Force:
	return AllForces[LocalPlayer]

func _on_board_panel_button_toggled(toggled_on: bool) -> void:
	BoardPanel.visible = toggled_on
	%BoardButton.button_pressed = toggled_on # Toggle on the board when you open the board panel

func _on_board_button_toggled(toggled_on: bool, button_index: int) -> void:
	var buttons : Array[Button] = [%BoardButton, %BaseButton, %UnitsButton, %UpgradeButton, %ItemButton, %ViewButton]
	ButtonGrid.visible = !toggled_on if button_index == 0 else toggled_on
	var force_ability_set = get_current_player().ForceAbilities.get(buttons[button_index].text)
	%ButtonGrid.BoundAbilitySet = force_ability_set
	

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
	var UnitScene: Unit = UnitScene.instantiate() as Unit
	UnitScene.set_unit(TestUnit)
	UnitScene.OwningForce = active_wave.ForceLeft
	Battlefield.create_wave(active_wave.ForceLeft, CurrentWave, UnitScene)
	
	# Generate the next wave
	var NewWave : Wave = Wave.new(Team1.Forces[CurrentWave % Team1.Forces.size()], Team2.Forces[CurrentWave % Team2.Forces.size()])
	WaveQueue.push_back(NewWave)	
	CurrentWave += 1

func view_board(board : Board) -> void:
	if(!board.is_node_ready()):
		return
	var parent_viewport = board.get_parent() as Viewport
	if(parent_viewport):
		%BoardView.texture = parent_viewport.get_texture()
		CurrentViewedBoard = board

func _on_board_view_gui_input(event: InputEvent) -> void:
	if(CurrentViewedBoard):
		var parent_viewport = CurrentViewedBoard.get_parent() as Viewport
		if(parent_viewport):
			parent_viewport.push_input(event)


func _on_button_grid_ability_wants_run(ability: BaseAbility, button: AbilityButton) -> void:
	#lower the panel
	%ButtonGrid.visible = false
	#run the ability
	get_current_player().Abilities.run_ability(ability)
