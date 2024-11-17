@tool
class_name UserInteractionAbility
extends BaseAbility

enum ConfirmationMode { Confirmed, Cancel }

func wait_user_confirmation(force : Force): # -> [confirmation_mode, location]
	while(true):
		var input_event : InputEvent = await force.force_input_pressed
		if input_event.is_action("action_cancel"):
			return [ConfirmationMode.Cancel, Vector2.ZERO]
		if input_event.is_action("action_confirm"):
			return [ConfirmationMode.Confirmed, force.OwningBoard.get_viewport().get_mouse_position()]
