@tool
extends BTAction

@export var _move_target: StringName = &"move_target"

@export var tolerance := 10

func _generate_name() -> String:
	return "Move To Target: %s " % LimboUtility.decorate_var(_move_target)

func _tick(delta: float) -> Status:
	var unit = agent as UnitNode
	var movespeed : float = unit.PixelsPerMovespeedUnit * (unit.UnitType.MovementSpeed.get_value_at())
	
	# move to the center of the destination tile
	var tile_destination : Vector2i = blackboard.get_var(_move_target)
	
	if tile_destination - unit.grid_position == Vector2i.ZERO:
		return SUCCESS
	
	var global_destination : Vector2 = Battlefield.tile_position_to_global_position(tile_destination)
	var movement_velocity : Vector2 = movespeed * (global_destination - unit.global_position).normalized()
	unit.move(movement_velocity)
	
	return RUNNING
