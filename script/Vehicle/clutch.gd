class_name Clutch
extends Node

@export var friction := 250.0

var locked := true
var prev_av := 0.0

func get_reaction_torques(av1: float, av2: float, t1: float, t2: float, slip_torque: float, kick := 0.0):
	var max_clutch_torque := slip_torque + kick
	var delta_torque := t1 - t2
	var delta_av := av1 - av2
	var reaction_torques := Vector2.ZERO
	
	# Locked situations are handled in car and drivetrain scripts atm
	if locked:
		if absf(delta_torque) >= slip_torque:
			locked = false
	else:
		if absf(delta_av) < 0.5:
			locked = true
	
	if slip_torque <= 1.0:
		locked = false
	elif locked:
		if absf(delta_torque) >= slip_torque:
			locked = false
	else:
		if absf(delta_av) < 0.5:
			locked = true
	# Apply torque smoothly based on the difference in speed. 
	# A stiffness of 200.0 acts as a viscous damper, preventing the +/- 400 flip.
	var stiffness = 40.0
	var applied_torque = clamp(delta_av * stiffness, -max_clutch_torque, max_clutch_torque)
	
	reaction_torques.x = applied_torque
	reaction_torques.y = -applied_torque

	return reaction_torques
	
