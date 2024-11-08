class_name Board
extends Node2D

var OwningForce : Force

@onready var Camera : Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()

func _input(event: InputEvent) -> void:
	print("board sees " + event.as_text())
