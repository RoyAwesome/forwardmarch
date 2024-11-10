class_name AbilityButton
extends NinePatchRect

signal ability_want_execute(Button : AbilityButton)

var BoundAbility : BaseAbility:
	set(value):
		BoundAbility = value
		$Button.disabled = false
		if not value:
			$Button.disabled = true
			$Button.icon = null
		elif  value.Icon:
			$Button.icon = value.Icon
		else: 
			$Button.icon = AbilityUnknownIcon

var AbilityUnknownIcon : Texture2D = preload("res://Content/ability_unknown.png")

func _ready() -> void:
	BoundAbility = null

func _on_button_pressed() -> void:
	if BoundAbility:
		ability_want_execute.emit(self)
