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

enum TEAM_RELATION {SELF, FRIENDLY, NEUTRAL, ENEMY }

#For forward march, the teams are hostile with each other.
# but hey i might reuse this code so lets stub out team hostility checking
func get_team_relationship(other_team : Team) -> TEAM_RELATION:
	if other_team == self: return TEAM_RELATION.SELF
	return TEAM_RELATION.ENEMY
