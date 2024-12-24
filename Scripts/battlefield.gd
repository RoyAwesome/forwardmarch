class_name Battlefield
extends Node2D

@export var CameraSpeed : int = 25
@onready var Camera : Camera2D = %Camera

const GridSize := Vector2i(16, 24)
const GridSizeMinusOne := GridSize - Vector2i.ONE #used in bounds checking
const TileSizeInPixels := 32

static func global_position_to_tile_position(pos : Vector2) -> Vector2i:
	return Vector2i((pos / TileSizeInPixels))
static func tile_position_to_global_position(pos : Vector2i) -> Vector2:
	return (pos * TileSizeInPixels)
	
const UnitScene : PackedScene = preload("res://Scenes/UnitNode.tscn")

func _physics_process(_delta: float) -> void:
	var mov :int = 0
	if(Input.is_action_pressed("camera_left")):
		mov = -1
	elif(Input.is_action_pressed("camera_right")):
		mov = 1
	var motion : int = mov * CameraSpeed;
	Camera.position.x += motion
	Camera.position.x = clamp(Camera.position.x, 200, 4300)

func create_wave(force : Force, wave : int):
	var spawn_zones : Array[Area2D] = [
		$Team1SpawnZone,
		$Team2SpawnZone
	]
	var WaveName := "Wave %d Force %d" % [wave, force.PlayerID]
	var UnitsToSpawn : Array[UnitNode] = []
	
	var board : Board = force.OwningBoard
	var spawn_area : Area2D = spawn_zones[force.OwningTeam.TeamIndex]
	var spawn_offset := global_position_to_tile_position(spawn_area.global_position)
	var test_scene = load("res://Scenes/UnitNode.tscn")
	
	UnitsToSpawn.resize(board.grid_array.size())
	for i in board.grid_array.size():
		var unit := board.grid_array[i]
		var duplicated_unit := test_scene.instantiate() as UnitNode
		duplicated_unit.UnitTemplate = unit
		var board_location = board.global_position_to_tile_position(unit.global_position)
		var battlefield_location = tile_position_to_global_position(board_location) + tile_position_to_global_position(spawn_offset)
		duplicated_unit.global_position = battlefield_location
		duplicated_unit.enable_ai = true
		duplicated_unit.OnBattlefield = self
		UnitsToSpawn[i] = duplicated_unit
	
	print("%s spawning %d units" % [WaveName, UnitsToSpawn.size()])
	
	if UnitsToSpawn.size() > 0:
		var WaveNode = Node2D.new()
		WaveNode.name = WaveName
		for unit in UnitsToSpawn:
			WaveNode.add_child(unit)
		$WaveContainer.add_child(WaveNode)

func get_units_around_location(grid_location : Vector2i, range : int) -> Array[UnitNode]:
	if range == 0: return []
	var units : Array[UnitNode]
	var nodes := $WaveContainer.get_children()
	for wave in nodes:
		for maybe_unit in wave.get_children():
			if maybe_unit is UnitNode:
				var unit := maybe_unit as UnitNode
				if grid_location.distance_squared_to(unit.grid_position) <= range * range:
					units.push_back(maybe_unit as UnitNode)
	return units
