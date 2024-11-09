@tool
class_name RangedAttack
extends BaseAttack

@export var AttackRange : Attribute = Attribute.new(100)

@export var NumTargets : Attribute = Attribute.new(1)
@export var AreaOfEffect : Attribute = Attribute.new(0)

@export var ProjectileSpeed : Attribute = Attribute.new(500)

@export var ProjectileSprite : Texture2D

@export var Homing : bool = true
