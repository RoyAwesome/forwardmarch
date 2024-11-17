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
	
	#wait for input that either succeeded or canceled
	var R = await wait_user_confirmation(force)
	if(R[0] == ConfirmationMode.Cancel):
		print("User Canceled Ability")
		return
	var location : Vector2 = R[1] as Vector2
	print("User wants unity at %s" % location) 
