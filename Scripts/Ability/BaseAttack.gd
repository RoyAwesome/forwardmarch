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

@export var AttackClass : AttackType
