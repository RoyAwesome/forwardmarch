class_name Team
extends Resource

@export var Forces: Array[Force]

enum UnitDirection { LEFT, RIGHT }
var MarchDirection : UnitDirection = UnitDirection.RIGHT
var TeamIndex := 0

func _init(in_forces : Array[Force], direction : UnitDirection = UnitDirection.RIGHT, index := 0) -> void:
	for force : Force in in_forces:
		force.OwningTeam = self
		Forces.push_back(force)		
	MarchDirection = direction
	TeamIndex = index
