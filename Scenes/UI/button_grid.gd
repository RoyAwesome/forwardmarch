class_name ButtonGrid
extends PanelContainer

var AbilityButtonScene : PackedScene = preload("res://Scenes/UI/AbilityButton.tscn")

var BoundAbilitySet : AbilitySet:
	set(value):
		BoundAbilitySet = value
		if(BoundAbilitySet):
			if(%GridContainer.is_node_ready()):
				var grid_children = %GridContainer.get_children()
				for i in grid_children.size():
					if i < BoundAbilitySet.Abilities.size():
						var ability_button = grid_children[i] as AbilityButton
						ability_button.BoundAbility = BoundAbilitySet.Abilities[i]
		else:
			if(%GridContainer.is_node_ready()):
				for c in %GridContainer.get_children():
					var ability_button = c as AbilityButton
					ability_button.BoundAbility = null
