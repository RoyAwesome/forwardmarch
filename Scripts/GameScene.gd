extends Node

@onready var BoardPanel : PanelContainer = %BoardPanel
@onready var ButtonGrid : PanelContainer = %ButtonGrid



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_board_panel_button_toggled(toggled_on: bool) -> void:
	BoardPanel.visible = toggled_on




func _on_board_button_toggled(toggled_on: bool, button_index: int) -> void:
	var buttons : Array = [%BoardButton, %BaseButton, %UnitsButton, %UpgradeButton, %ItemButton, %ViewButton]
	ButtonGrid.visible = !toggled_on if button_index == 0 else toggled_on
