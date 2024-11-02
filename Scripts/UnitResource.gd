@tool
class_name UnitResource
extends Resource
const Attribute : Script = preload("Attribute.gd")


@export var MaxHealth : Attribute = Attribute.new(100)
@export var MaxMana : Attribute = Attribute.new(0)

@export var Armor : Attribute = Attribute.new(0)
@export var AttackSpeed : Attribute = Attribute.new(0)
@export var BaseAttackColldown :Attribute = Attribute.new(1.0)

@export var Intelligence : Attribute = Attribute.new(0, 0)
@export var Agility : Attribute = Attribute.new(0, 0)
@export var BaseStrength : Attribute = Attribute.new(0, 0)

@export var Sprite : Texture2D

#Size of the unit in grid squares
@export var UnitSize : int = 1; 
