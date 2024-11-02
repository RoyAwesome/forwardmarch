class_name Attribute
extends Resource

@export var InitialValue = -1.0;
@export var GrowthPerLevel = -1.0;

var BaseValue = 0;
var CurrentValue = 0;
var CurrentLevel = 0;

func _init(initial_value = -1, growth_per_level = -1):
	if(initial_value >= 0 && InitialValue < 0):
		InitialValue = initial_value
	if(growth_per_level >= 0 && GrowthPerLevel < 0):
		GrowthPerLevel = growth_per_level
	
	BaseValue = 0 if(InitialValue < 0) else InitialValue
	compute_modifiers()

func compute_modifiers():
	CurrentValue = BaseValue
