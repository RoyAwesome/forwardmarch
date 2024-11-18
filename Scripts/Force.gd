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
	ForceAbilities["Units"] = AbilitySet.new()
	add_build_unit_ability(0, preload("res://Units/Human/Footman.tres"))

func add_build_unit_ability(index : int, unit_type: UnitResource):
	if not unit_type:
		push_error("unit_type is null!")
		return
	var unit_ability_set = ForceAbilities["Units"] as AbilitySet
	var build_unit_ability = BuildUnitAbility.new()
	build_unit_ability.UnitType = unit_type
	build_unit_ability.Icon = unit_type.Sprite
	build_unit_ability.Name = "Build %s" % unit_type.UnitName
	build_unit_ability.Description = unit_type.Description
	
	if unit_ability_set.Abilities.size() <= index:
		unit_ability_set.Abilities.resize(index + 1)
	unit_ability_set.Abilities[index] = build_unit_ability
	
func push_input(input : InputEvent):
	force_input_pressed.emit(input)
