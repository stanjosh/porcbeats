extends Area2D
class_name PlayCollider
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var line_2d: Line2D = $Line2D

func _ready() -> void:
	line_2d.points = collision_polygon_2d.polygon
