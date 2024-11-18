class_name Force
extends Resource

@export var PlayerID : int = 0

var OwningTeam : Team
var OwningBoard : Board

var Abilities : AbilityRunner

signal force_input_pressed(input : InputEvent)

var ForceAbilities : Dictionary = {
	"Units" : preload("res://Units/AbilitySets/ForceUnitAbilities.tres")
}

func _init(player_id : int, on_team : Team):
	PlayerID = player_id
	OwningTeam = on_team
	Abilities = AbilityRunner.new(self)
	
func push_input(input : InputEvent):
	force_input_pressed.emit(input)
