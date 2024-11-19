@tool
class_name BuildUnitAbility
extends UserInteractionAbility

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
	force.OwningBoard.put_unit_on_cursor(UnitType)
	
	#wait for input that either succeeded or canceled
	var R = await wait_user_confirmation(force)
	force.OwningBoard.hide_cursor()
	
	if(R[0] == ConfirmationMode.Cancel):
		print("User Canceled Ability")
		return
	force.OwningBoard.place_unit_at_location(UnitType, force.OwningBoard.get_cursor_grid_location())
