class_name GameScene
extends Node

const UnitScene : PackedScene = preload("res://Scenes/UnitNode.tscn")
const BoardScene : PackedScene = preload("res://Scenes/Board.tscn")
const TestUnit : UnitResource = preload("res://Units/TestUnit.tres")

@onready var BoardPanel : PanelContainer = %BoardPanel
@onready var BattlefieldNode : Battlefield = $UI/SubViewportContainer/SubViewport/Battlefield

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
	BoardPanel.visible = false #I always leave this on when doing work in the scene tree.  disable it so i dont make that mistake
	TeamDisplays = [%Team1Display, %Team2Display]
	
	# generate a force for each player
	AllForces.resize(6)
	for i in 6:
		var force := create_player_force(i)
		AllForces[i] = force
		
	Team1 = Team.new([AllForces[0], AllForces[1], AllForces[2]], Team.UnitDirection.RIGHT, 0)
	Team2 = Team.new([AllForces[3], AllForces[4], AllForces[5]], Team.UnitDirection.LEFT, 1)

	for i in 3:
		WaveQueue.push_back(Wave.new(Team1.Forces[i % Team1.Forces.size()], Team2.Forces[i % Team2.Forces.size()]))	
	
	for i in TeamDisplays.size():		
		TeamDisplays[i].AssignedTeam = Team1 if i%2 == 0 else Team2
	
	WaveTimer.start()
	
	AllForces[LocalPlayer].OwningBoard.ready.connect(func (): 
		view_board(AllForces[LocalPlayer].OwningBoard))
	
	# put an enemy footman on the board for testing
	var footman : UnitResource = load("res://Units/Human/Footman.tres")
	AllForces[3].OwningBoard.place_unit_at_location(footman, Vector2i(2, 3))
	

func create_player_force(player_id : int) -> Force:
	var force : Force = Force.new(player_id, null)	

	# create a board for the player
	var viewport = SubViewport.new()
	viewport.name = "Player %d" % player_id
	
	var PlayerBoard : Board = BoardScene.instantiate()
	PlayerBoard.name = "Player %d Board" % player_id
	PlayerBoard.OwningForce = force
	viewport.size = Vector2(832, 832)
	
	viewport.add_child.call_deferred(PlayerBoard)
	
	if(player_id == LocalPlayer):
		CurrentPlayerBoard = PlayerBoard
	get_tree().root.add_child.call_deferred(viewport)
	
	force.OwningBoard = PlayerBoard
	return force

func get_current_player() -> Force:
	return AllForces[LocalPlayer]

func _on_board_panel_button_toggled(toggled_on: bool) -> void:
	BoardPanel.visible = toggled_on
	%BoardButton.button_pressed = toggled_on # Toggle on the board when you open the board panel
	

func _on_board_button_toggled(toggled_on: bool, button_index: int) -> void:
	var buttons : Array[Button] = [%BoardButton, %BaseButton, %UnitsButton, %UpgradeButton, %ItemButton, %ViewButton]
	%ButtonGrid.visible = !toggled_on if button_index == 0 else toggled_on
	var force_ability_set = get_current_player().ForceAbilities.get(buttons[button_index].text)
	%ButtonGrid.BoundAbilitySet = force_ability_set
	

func timer_for_force(force : Force) -> int:
	for wave in WaveQueue.size():
		if(WaveQueue[wave].ForceLeft == force || WaveQueue[wave].ForceRight == force):
			return floor(WaveTimer.time_left + (WaveTimer.wait_time * wave))
	return -1
	
func timer_for_wave(wave : Wave) -> int:
	for w in WaveQueue.size():
		if(WaveQueue[w] == wave):
			return floor(WaveTimer.time_left + (WaveTimer.wait_time * w))
	return -1

func _on_wave_timer_timeout() -> void:
	# Spawn those player's waves
	
	var active_wave : Wave = WaveQueue.pop_front()
	# Spawn the wave
	BattlefieldNode.create_wave(active_wave.ForceLeft, CurrentWave)
	BattlefieldNode.create_wave(active_wave.ForceRight, CurrentWave)
	
	# Generate the next wave
	var NewWave : Wave = Wave.new(Team1.Forces[CurrentWave % Team1.Forces.size()], Team2.Forces[CurrentWave % Team2.Forces.size()])
	WaveQueue.push_back(NewWave)	
	CurrentWave += 1

func view_board(board : Board) -> void:
	if(!board.is_node_ready()):
		return
	%BoardView.CurrentlyViewedBoard = board
	var left_visible := board.OwningForce.OwningTeam and board.OwningForce.OwningTeam.MarchDirection == Team.UnitDirection.LEFT
	%MarchLeftIndicator.visible = left_visible
	%MarchRightIndicator.visible = !left_visible

func _on_button_grid_ability_wants_run(ability: BaseAbility, _button: AbilityButton) -> void:
	#lower the panel
	%BoardButton.button_pressed = true
	#run the ability
	get_current_player().Abilities.run_ability(ability)
