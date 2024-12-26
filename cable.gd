extends Node2D

@onready var start_point: Area2D = $StartPoint
@onready var end_point: Area2D = $EndPoint
@onready var line: Line2D = $Line

@export var num_segments : float = 10
@export var cable_curve : Curve

var length : float :
	get:
		return (start_point.position - end_point.position).length()

func _ready() -> void:
	update_segments()

func _process(delta: float) -> void:
	if start_point.get_meta("dragging", false):
		start_point.position = get_local_mouse_position()
		update_segments()
	elif end_point.get_meta("dragging", false):
		end_point.position = get_local_mouse_position()
		update_segments()


func update_segments() -> void:
	line.clear_points()
	var offset = start_point.position - end_point.position
	var pos = start_point.position
	line.add_point(pos)
	for segment in num_segments + 1:
		print(segment / num_segments)
		var ratio = (1 / num_segments) * segment
		pos -= offset / num_segments

		pos.y = sin((pos.y - start_point.position.y) * PI / (end_point.position.y - start_point.position.y)) * 10
		line.add_point(pos)
	



func _on_start_point_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		start_point.set_meta("dragging", true)
	if event is InputEventMouseButton and !event.is_pressed():
		start_point.set_meta("dragging", false)


func _on_end_point_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		end_point.set_meta("dragging", true)
	if event is InputEventMouseButton and !event.is_pressed():
		end_point.set_meta("dragging", false)
