class_name UnitNode
extends CharacterBody2D

@onready var MainSprite : Sprite2D = %MainSprite

@export var PixelsPerMovespeedUnit : float = 8

var grid_position : Vector2i:
	get():
		return Battlefield.global_position_to_tile_position(global_position)

var OwningForce : Force

var enable_ai : bool = false:
	set(value):
		enable_ai = value
		$BTPlayer.active = true

# Unit this is copied from
var UnitTemplate : UnitNode:
	set(value):
		UnitTemplate = value
		if UnitTemplate:
			UnitType = UnitTemplate.UnitType
			OwningForce = UnitTemplate.OwningForce
var UnitType : UnitResource:
	set(value):
		UnitType = value
		if UnitType and is_node_ready():
			if(UnitType.Sprite):
				MainSprite.texture = UnitType.Sprite
				scale = Vector2(UnitType.UnitSize * 32, UnitType.UnitSize * 32) / UnitType.Sprite.get_size() 
			if(UnitType.UnitSize >= 1):
				($CollisionShape2D.shape as CircleShape2D).radius = UnitType.UnitSize


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(UnitType):
		UnitType = UnitType
	
func move(dir : Vector2):
	velocity = dir
	move_and_slide()
