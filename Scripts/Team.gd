class_name Team
extends Resource

@export var Forces: Array[Force]

func _init(in_forces : Array[int]) -> void:
	for i in in_forces:
		Forces.push_back(Force.new(i))
