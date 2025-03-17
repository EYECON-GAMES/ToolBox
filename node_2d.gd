@tool extends Node2D
@export var c:Curve
@onready var lines:=$Lines

var pressed:=false
var current_line:Line2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		pressed = event.pressed

		if pressed:
			current_line = Line2D.new()
			current_line.default_color = Color.AQUAMARINE
			current_line.width = 12.0
			current_line.end_cap_mode=Line2D.LINE_CAP_ROUND
			current_line.begin_cap_mode=Line2D.LINE_CAP_ROUND
			current_line.width_curve = c
			current_line.antialiased=true
			lines.add_child(current_line)

	if event is InputEventMouseMotion && pressed:
		current_line.add_point(event.position)
