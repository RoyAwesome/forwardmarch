class_name Force
extends Resource

@export var PlayerID : int = 0

var OwningTeam : Team

func _init(player_id : int, on_team : Team):
	PlayerID = player_id
	OwningTeam = on_team
