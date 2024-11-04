class_name Battlefield
extends Node2D

@export var CameraSpeed : int = 25
@onready var Camera : Camera2D = %Camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var mov :int = 0
	if(Input.is_action_pressed("camera_left")):
		mov = -1
	elif(Input.is_action_pressed("camera_right")):
		mov = 1
	var motion : int = mov * CameraSpeed;
	Camera.position.x += motion
	Camera.position.x = clamp(Camera.position.x, 200, 4300)

func create_wave(force : Force, wave : int, unit : Unit):
	var WaveNode = Node2D.new()
	WaveNode.name = "Wave %d Force %d" % [wave, force.PlayerID]
	$WaveContainer.add_child(WaveNode)
		
	WaveNode.add_child(unit)
