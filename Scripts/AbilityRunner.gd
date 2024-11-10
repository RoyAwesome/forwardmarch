class_name AbilityRunner
extends Resource

var Host

func _init(host) -> void:	
	assert(host)
	Host = host

class AbilityInstance:
	var Target : Object
	var Runner : AbilityRunner
	var Ability : BaseAbility

func run_ability(ability : BaseAbility, target : Object = null):
	if not ability:
		push_error("Must call RunAbility with a valid ability")
		return
	var instance : AbilityInstance = AbilityInstance.new()
	instance.Runner = self
	instance.Ability = ability
	instance.Target = target
	print_debug("Running Ability %s" % ability.get_class())
	await ability.run(instance)
