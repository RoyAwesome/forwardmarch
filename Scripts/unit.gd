class_name UnitNode
extends Node2D

@onready var MainSprite : Sprite2D = %MainSprite
@onready var NavAgent : NavigationAgent2D = %NavigationAgent2D

@export var PixelsPerMovespeedUnit : float = 1

var OwningForce : Force

# Unit this is copied from
var UnitTemplate : UnitNode
var UnitType : UnitResource:
	set(value):
		UnitType = value
		if UnitType and is_node_ready():
			if(UnitType.Sprite):
				MainSprite.texture = UnitType.Sprite
				scale = Vector2(UnitType.UnitSize * 32, UnitType.UnitSize * 32) / UnitType.Sprite.get_size() 
			if(UnitType.UnitSize >= 1):
				NavAgent.radius = 70 * UnitType.UnitSize


func init_from_template(unit : UnitNode):
	UnitTemplate = unit
	if UnitTemplate.UnitType:
		UnitType = UnitTemplate.UnitType

func set_movement_target(in_position: Vector2):
	NavAgent.set_target_position(in_position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(UnitType):
		UnitType = UnitType
	
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
