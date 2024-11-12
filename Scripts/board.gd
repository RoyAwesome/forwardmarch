class_name Board
extends Node2D

var OwningForce : Force

@onready var Camera : Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()

func _input(event: InputEvent) -> void:
	if(OwningForce):
		OwningForce.force_input_pressed.emit(event)

func show_grid(visible : bool):
	pass

func put_unit_on_cursor(unit : UnitResource):
	pass
