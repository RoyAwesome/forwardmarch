class_name Battlefield
extends Node2D

@export var CameraSpeed : int = 25
@onready var Camera : Camera2D = %Camera

func _physics_process(_delta: float) -> void:
	var mov :int = 0
	if(Input.is_action_pressed("camera_left")):
		mov = -1
	elif(Input.is_action_pressed("camera_right")):
		mov = 1
	var motion : int = mov * CameraSpeed;
	Camera.position.x += motion
	Camera.position.x = clamp(Camera.position.x, 200, 4300)

func create_wave(force : Force, wave : int, unit : UnitNode):
	var WaveNode = Node2D.new()
	WaveNode.name = "Wave %d Force %d" % [wave, force.PlayerID]
	$WaveContainer.add_child(WaveNode)
		
	WaveNode.add_child(unit)
