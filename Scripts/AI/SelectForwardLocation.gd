@tool
extends BTAction

@export var _move_target: StringName = &"move_target"

func _tick(delta: float) -> Status:
	var unit := agent as UnitNode
	var walk_direction := Vector2i.RIGHT
	if unit.OwningForce.OwningTeam.MarchDirection == Team.UnitDirection.LEFT:
		walk_direction = Vector2i.LEFT
	blackboard.set_var(_move_target, unit.grid_position + walk_direction)
	return SUCCESS
	
