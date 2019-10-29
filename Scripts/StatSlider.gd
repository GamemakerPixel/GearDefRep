extends HSlider

signal costChange

func _ready():
	_on_value_changed(value)

func _on_increase_button_down():
	value += step

func _on_decrease_button_down():
	value -= step

func _on_value_changed(value):
	if name == "DamageSlider" || name == "RangeSlider":
		$Value.text = str(value)
	elif name == "SpeedSlider":
		if value == 1:
			$Value.text = "Very Slow (5s)"
		elif value == 2:
			$Value.text = "Slow (3s)"
		elif value == 3:
			$Value.text = "Average (1s)"
		elif value == 4:
			$Value.text = "Fast (0.5s)"
	var percentValue = value/max_value * 100.0
	var roundedPercentValue = int(percentValue)
	emit_signal("costChange", name, roundedPercentValue)

func setMaxValue(_value):
	max_value = _value
	_on_value_changed(value)