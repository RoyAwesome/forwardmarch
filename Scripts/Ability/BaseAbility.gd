@tool
class_name BaseAbility
extends Resource

#todo

@export var Name : String
@export_multiline var Description : String
@export var Icon : Texture2D

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
