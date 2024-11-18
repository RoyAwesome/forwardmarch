class_name UserDisplay
extends HBoxContainer

@onready var Text : RichTextLabel = $Text

@onready var CurrentGameScene : GameScene = $/root/GameScene
@export var Group : int = 0

var AssignedForce: Force

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		
	if(!CurrentGameScene || !CurrentGameScene.WaveTimer || CurrentGameScene.WaveTimer.is_stopped()):
		Text.text = "---"
		return	
	if(!AssignedForce):
		Text.text = "---"
		return
	
	Text.text = "%3.0f" % (CurrentGameScene.timer_for_force(AssignedForce))
