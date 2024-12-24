@tool
class_name BaseAbility
extends Resource

#todo

@export var Name : String
@export_multiline var Description : String
@export var Icon : Texture2D

#AI will select higher priority abilities over lower priority abilities
@export var AI_Priority : int

@export_flags("Enemy:1", "Friendly:2", "Neutral:4", "Self:8", "All_Hostile:5", "All_Targets:16") 
var TargetFlags := 5

enum TargetFlagValue {Enemy = 1, Friendly = 2, Neutral = 4, Self = 8}

#todo: generalize costs.  This can be gold, time, or mana
@export var ManaCost : Attribute = Attribute.new(0)

#the unlock required for this ability to function.  If null, no effect is required
@export var UnlockRequirement : Effect

enum DisplayModeEnum {
	Normal,
	Hidden,
	Attack
}
@export var DisplayMode : DisplayModeEnum

func play_anim_awaitable(player : AnimationPlayer, anim : StringName):
	if not player.has_animation(anim):
		return
	player.play(anim)
	while(true):
		var finished_anim : StringName = await player.animation_finished
		if finished_anim == anim:
			break;

func can_target(unitSelf : UnitNode, unitTarget : UnitNode) -> bool:
	var relation := unitSelf.get_relation_to(unitTarget)
	if relation == Team.TEAM_RELATION.SELF and (TargetFlags & TargetFlagValue.Self):
		return true
	if relation == Team.TEAM_RELATION.FRIENDLY and (TargetFlags & TargetFlagValue.Friendly):
		return true
	if relation == Team.TEAM_RELATION.ENEMY and (TargetFlags & TargetFlagValue.Enemy):
		return true
	if relation == Team.TEAM_RELATION.NEUTRAL and (TargetFlags & TargetFlagValue.Neutral):
		return true
	return false

func run(_ability_instance : AbilityRunner.AbilityInstance):
	pass
	
func can_run(_ability_instance : AbilityRunner.AbilityInstance) -> bool:
	return false;

func acquire_targets(_ability_instance : AbilityRunner.AbilityInstance) -> Array[Object]:
	return []
