class_name TeamDisplay
extends HBoxContainer

var AssignedTeam : Team:
	set(value):
		AssignedTeam = value
		if AssignedTeam.Forces.size() >= 0:
			$Player1.AssignedForce = AssignedTeam.Forces[0]
		if AssignedTeam.Forces.size() >= 1:
			$Player2.AssignedForce = AssignedTeam.Forces[1]
		if AssignedTeam.Forces.size() >= 2:
			$Player3.AssignedForce = AssignedTeam.Forces[2]
