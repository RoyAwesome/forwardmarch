@tool
class_name BuildUnitAbility
extends BaseAbility

@export var UnitType : UnitResource

#todo - Allow the player to select a unit, 
# then when a valid placement is made on the board, place that unit on the board
func run(ability_instance : AbilityRunner.AbilityInstance):
	print("Build Unit Ability")
	var force : Force = ability_instance.Runner.Host as Force
	if not force:
		push_error("Build Unit ability was called by something other than a force")
		return
	#place the unit on the user's cursor
	
	#wait for input that either succeeded or canceled
	while true:
		var input_event : InputEvent = await force.force_input_pressed	
		print(input_event.as_text())
