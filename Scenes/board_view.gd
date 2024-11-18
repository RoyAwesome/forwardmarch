extends TextureRect

var CurrentlyViewedBoard : Board:
	set(value):
		CurrentlyViewedBoard = value
		if CurrentlyViewedBoard:
			var vp = CurrentlyViewedBoard.get_viewport()
			texture = vp.get_texture()
		else:
			texture = null

func _gui_input(event: InputEvent) -> void:
	if CurrentlyViewedBoard and visible:
		var screen_size = Vector2(get_tree().get_root().size)
		var set_width = ProjectSettings.get("display/window/size/viewport_width")
		var set_height = ProjectSettings.get("display/window/size/viewport_height")
		var real_size = size * screen_size / Vector2(set_width, set_height)
		
		var scaling_factor = (texture.get_size() / real_size)
		var scaling_xform = Transform2D.IDENTITY
		scaling_xform = scaling_xform.scaled(scaling_factor)
		event = event.xformed_by(scaling_xform)
		
		var viewport := CurrentlyViewedBoard.get_viewport()		
		viewport.push_input(event, true)
