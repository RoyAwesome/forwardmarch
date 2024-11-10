class_name AbilityButton
extends NinePatchRect

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
	pass # Replace with function body.
	#Get the current force
	# Execute the ability on the force
