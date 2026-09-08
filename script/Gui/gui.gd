extends Control



@onready var car = get_parent()
@onready var speedlabel = %speedlable
@onready var gearlabel = %gearlable
@onready var rpmlabel = %rpmlable
@onready var fuellabel = %fulelable


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speedlabel.text = "Speed = %d" % int(car.speedo)
	gearlabel.text = "gear = %d" % car.drivetrain.selected_gear
	rpmlabel.text = "RPM = %d" % int(car.rpm)
	fuellabel.text = "Fuel = %3.2f" % car.fuel
