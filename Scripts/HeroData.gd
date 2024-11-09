@tool
class_name HeroData
extends Resource

@export var MaxLevel : Attribute = Attribute.new(10)

@export var ExpToLevel : Curve

@export var Intelligence : Attribute = Attribute.new(0, 0)
@export var Agility : Attribute = Attribute.new(0, 0)
@export var Strength : Attribute = Attribute.new(0, 0)
