class_name Board
extends Node2D

var OwningForce : Force

const GridSize := Vector2i(16, 24)
const GridSizeMinusOne := GridSize - Vector2i.ONE #used in bounds checking
const BoardGridOffset := Vector2i(4, 1)
const TileSizeInPixels := 32

var grid_array : Array[UnitNode]

@onready var Camera : Camera2D = $Camera2D

var cursor_unit_size := 0

func global_position_to_tile_position(pos : Vector2) -> Vector2i:
	var raw_pos := Vector2i((pos / TileSizeInPixels)) - BoardGridOffset
	return raw_pos.clamp(Vector2i.ZERO, GridSizeMinusOne)
func tile_position_to_global_position(pos : Vector2i) -> Vector2:
	return (pos * TileSizeInPixels) + (BoardGridOffset * TileSizeInPixels)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()
	hide_cursor()

func place_unit_at_location(unit : UnitResource, location: Vector2i):
	if not unit: 
		push_error("Unit must be valid") 
		return
	var unit_scene := load("res://Scenes/UnitNode.tscn")
	var instanced_unit := unit_scene.instantiate() as UnitNode
	instanced_unit.UnitType = unit
	instanced_unit.global_position = tile_position_to_global_position(location)
	$UnitContainer.add_child(instanced_unit)
	grid_array.push_back(instanced_unit)
	

func _input(event: InputEvent) -> void:
	if(OwningForce):
		OwningForce.push_input(event)
	var mouse_input : InputEventMouseMotion = event as InputEventMouseMotion
	if(mouse_input and %Cursor.visible):
		var tile_position := global_position_to_tile_position(mouse_input.position)
		var offset := (cursor_unit_size - 1) * Vector2i.ONE
		if(tile_position.x + offset.x >= GridSizeMinusOne.x):
			tile_position.x -= offset.x
		if(tile_position.y + offset.y >= GridSizeMinusOne.y):
			tile_position.y -= offset.y
		%Cursor.global_position = tile_position_to_global_position(tile_position)
		
func get_cursor_grid_location() -> Vector2i:
	return global_position_to_tile_position(%Cursor.global_position)

func show_grid(should_be_visible : bool):
	%GridLayer.visible = should_be_visible

func put_unit_on_cursor(unit : UnitResource):
	if not unit:
		hide_cursor()
		return
	%Cursor.visible = true
	%Cursor.texture = unit.Sprite
	cursor_unit_size = unit.UnitSize
	%Cursor.scale = Vector2(unit.UnitSize * 32, unit.UnitSize * 32) / unit.Sprite.get_size() 
	show_grid(true)
	
func hide_cursor():
	%Cursor.visible = false
	show_grid(false)
