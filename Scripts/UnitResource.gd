@tool
class_name UnitResource
extends Resource



enum ArmorType {
	Unarmored,
	Light,
	Medium,
	Heavy, 
	Fortified,
	Hero,
	Base
}

@export var MaxHealth : Attribute = Attribute.new(100)
@export var MaxMana : Attribute = Attribute.new(0)

@export var Armor : Attribute = Attribute.new(0)

@export var Cost : Attribute = Attribute.new(0)

@export var MovementSpeed : Attribute = Attribute.new(10)

@export var Sprite : Texture2D

#Size of the unit in grid squares
@export var UnitSize : int = 1; 

@export var Flying : bool = false

@export var ArmorClass : ArmorType

@export var UnitName : String
@export_multiline var Description : String

@export var Hero : HeroData

@export var AbilitySets : Array[AbilitySet]

@export var IsEnemyWhenUnowned : bool = true
