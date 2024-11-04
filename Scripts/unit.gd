class_name Unit
extends Node2D
const UnitResource = preload("res://Scripts/UnitResource.gd")

@onready var MainSprite : Sprite2D = %MainSprite
@onready var NavAgent : NavigationAgent2D = %NavigationAgent2D

@export var PixelsPerMovespeedUnit : float = 1

var OwningForce : Force

# Unit this is copied from
var UnitTemplate : Unit
var UnitType : UnitResource;


func init_from_template(unit : Unit):
	UnitTemplate = unit
	set_unit(unit.UnitType)	

func set_unit(unit : UnitResource):
	UnitType = unit
	if(is_node_ready()):
		if(unit.Sprite):
			MainSprite.texture = unit.Sprite
		if(unit.UnitSize >= 1):
			NavAgent.radius = 70 * unit.UnitSize

func set_movement_target(position: Vector2):
	NavAgent.set_target_position(position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(UnitType):
		set_unit(UnitType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var movement_delta : float = 0
func _physics_process(delta: float) -> void:
	if(NavAgent.is_navigation_finished()):
		return
	movement_delta = UnitType.MovementSpeed.CurrentValue * delta
	
	var next_path_position: Vector2 = NavAgent.get_next_path_position()
	var current_position : Vector2 = global_position
	var new_velocity : Vector2 = (next_path_position - current_position).normalized() * movement_delta
	if(NavAgent.avoidance_enabled):
		NavAgent.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)
