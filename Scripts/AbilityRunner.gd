class_name AbilityRunner
extends Resource

var Host

func _init(host) -> void:	
	assert(host)
	Host = host

class AbilityInstance:
	var Target : Array[Object]
	var Runner : AbilityRunner
	var Ability : BaseAbility
	var Level : int = 1
	func is_valid() -> bool:
		return true if Runner and Ability else false

func acquire_targets(ability : BaseAbility) -> AbilityInstance:
	if not ability:
		push_error("Must call RunAbility with a valid ability")
		return
	var instance : AbilityInstance = AbilityInstance.new()
	instance.Runner = self
	instance.Ability = ability
	instance.Target = ability.acquire_targets(instance)
	return instance

func can_run_ability(ability_instance : AbilityInstance) -> bool:
	if not ability_instance or not ability_instance.is_valid():
		push_error("Must call can_run_ability with a valid ability instance")
		return false
	return ability_instance.Ability.can_run(ability_instance)

func run_ability_instance(ability_instance : AbilityInstance):
	if not ability_instance or not ability_instance.is_valid():
		push_error("Must call can_run_ability with a valid ability instance")
		return false
	await ability_instance.Ability.run(ability_instance)

func run_ability(ability : BaseAbility, target : Object = null):
	if not ability:
		push_error("Must call RunAbility with a valid ability")
		return
	var instance : AbilityInstance = AbilityInstance.new()
	instance.Runner = self
	instance.Ability = ability
	instance.Target = [target]
	print_debug("Running Ability %s" % ability.get_class())
	await run_ability_instance(instance)
