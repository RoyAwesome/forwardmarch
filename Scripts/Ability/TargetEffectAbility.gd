@tool
class_name TargetEffectAbility
extends BaseAbility

#todo - Apply an effect to a target

#The effect to apply to the target
#@export var Effect : EffectResource


@export_flags("Friendly", "Enemy", "NotFlying", "NotMechanical", "NotUndead") 
var TargetFlags : int = 0
