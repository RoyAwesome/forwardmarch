@tool
class_name BaseAttack
extends BaseAbility

enum AttackType {
	Normal,
	Magic, 
	Pierce,
	Spell,
	Siege,
	Hero,
	Chaos
}

@export var AttackSpeed : Attribute = Attribute.new(0)
@export var BaseAttackCooldown :Attribute = Attribute.new(1.0)

@export var MinAttackDamage : Attribute = Attribute.new(0)
@export var MaxAttackDamage : Attribute = Attribute.new(1)

@export var AttackWindupAnimation : StringName = &"attack_windup"
@export var AttackWindDownAnimation: StringName = &"attack_winddown"

@export var AttackClass : AttackType



@export var AttackRange : Attribute = Attribute.new(0)
# The scan range for the attack.  This is used to acquire targets to move to
# if 0, the attack wont move to targets, and instead only acquire targets that are in range
@export var AttackScanRange : Attribute = Attribute.new(0)

@export var MaxAttackTargets : Attribute = Attribute.new(1)

func attack_targets(unit_self : UnitNode, unit_target : Array[UnitNode]):
	pass


func do_attack(_ability_instance : AbilityRunner.AbilityInstance):
	var unit := _ability_instance.Runner.Host as UnitNode
	var target := _ability_instance.Target as Array[UnitNode]
	# await the windup animation
	await play_anim_awaitable(unit.AnimPlayer, AttackWindupAnimation)
	
	# do the attack or projectile
	await attack_targets(unit, target)
	
	await play_anim_awaitable(unit.AnimPlayer, AttackWindDownAnimation)
	

func can_run(_ability_instance : AbilityRunner.AbilityInstance) -> bool:
	return false if not _ability_instance.Target else true



func acquire_targets(_ability_instance : AbilityRunner.AbilityInstance) -> Array[Object]:
	var attack_scan_range = AttackScanRange.get_value_at(_ability_instance.Level)
	var scan_range = AttackRange.get_value_at(_ability_instance.Level)
	if attack_scan_range > 0:
		scan_range = attack_scan_range
	
	var unit : UnitNode = _ability_instance.Runner.Host as UnitNode
	var try_targets := unit.OnBattlefield.get_units_around_location(unit.grid_position, scan_range)
	try_targets.sort_custom(func(a : UnitNode, b : UnitNode):
		return a.grid_position.distance_squared_to(unit.grid_position) > b.grid_position.distance_squared_to(unit.grid_position))
	var out_targets : Array[Object] = []
	var targets_collected = 0
	for try_target_unit in try_targets:
		if can_target(unit, try_target_unit):
			out_targets.push_back(try_target_unit)
			targets_collected += 1
			if targets_collected >= MaxAttackTargets.get_value_at(_ability_instance.Level):
				break
	return out_targets
