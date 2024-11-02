extends Node2D
const UnitResource = preload("res://Scripts/UnitResource.gd")

@onready var MainSprite : Sprite2D = %MainSprite
@onready var NavAgent : NavigationAgent2D = %NavigationAgent2D

var UnitType : UnitResource;

func SetUnit(unit : UnitResource)
	UnitType = unit
	if(unit.Sprite):
		MainSprite.texture = unit.Sprite
	if(unit.UnitSize >= 1):
		NavAgent.radius = 70 * unit.UnitSize


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
