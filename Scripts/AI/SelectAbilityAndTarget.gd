@tool
extends BTAction

@export var _ability_to_use: StringName = &"desired_ability"

func _tick(delta: float) -> Status:
	var unit := agent as UnitNode
	var unit_type := unit.UnitType
	
	var AllAbilities : Array[BaseAbility]
	for ability_set in unit_type.AbilitySets:
		for ability in ability_set.Abilities:
			AllAbilities.push_back(ability)
	AllAbilities.sort_custom(func (a,b): a.AI_Priority > b.AI_Priority)	
	# loop through all of the abilities
	for ability in AllAbilities:
		# find a target that we can use the ability on
		var ability_instance := unit.Abilities.acquire_targets(ability)
		# find an ability that we can use (check costs, etc)
		if not ability.can_run(ability_instance):
			continue
		#we've acquired an ability to use, so set this ability instance to use
		blackboard.set_var(_ability_to_use, ability_instance)
		print("Found ability %s" % ability_instance.Ability.Name)
		return Status.SUCCESS	
	# set the target of this ability, or fail out if no abilities work.
	blackboard.set_var(_ability_to_use, null)
	return Status.FAILURE
