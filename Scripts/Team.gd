class_name Team
extends Resource

@export var Forces: Array[Force]

enum UnitDirection { LEFT, RIGHT }
var MarchDirection : UnitDirection = UnitDirection.RIGHT

func _init(in_forces : Array[Force], direction : UnitDirection = UnitDirection.RIGHT) -> void:
	for force : Force in in_forces:
		force.OwningTeam = self
		Forces.push_back(force)		
	MarchDirection = direction
