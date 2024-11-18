class_name Board
extends Node2D

var OwningForce : Force

@onready var Camera : Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()
	hide_cursor()

func _input(event: InputEvent) -> void:
	print("board %s" % event.as_text())
	if(OwningForce):
		OwningForce.push_input(event)
	var mouse_input : InputEventMouseMotion = event as InputEventMouseMotion
	if(mouse_input and %Cursor.visible):
		%Cursor.global_position = floor(mouse_input.position / 32) * 32
		
func get_cursor_grid_location() -> Vector2i:
	var loc =  ($BaseLayer.global_position - %Cursor.global_position) / 32
	return Vector2i(floor(loc))

func show_grid(should_be_visible : bool):
	%GridLayer.visible = should_be_visible

func put_unit_on_cursor(unit : UnitResource):
	if not unit:
		hide_cursor()
		return
	%Cursor.visible = true
	%Cursor.texture = unit.Sprite
	%Cursor.scale = Vector2(unit.UnitSize * 32, unit.UnitSize * 32) / unit.Sprite.get_size() 
	show_grid(true)
	
func hide_cursor():
	%Cursor.visible = false
	show_grid(false)
