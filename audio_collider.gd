@tool
extends Node2D

@onready var connector_line: Line2D = $ConnectorLine
@onready var collide_area: Area2D = $CollideArea
@onready var collision_polygon_2d: CollisionPolygon2D = $CollideArea/CollisionPolygon2D
@onready var collider_line: Line2D = $CollideArea/ColliderLine
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $CollideArea/AudioStreamPlayer2D




@export var length : float = 10
@export var speed : float = 10
@export var reverse_on_hit : bool = true

func _ready() -> void:
	audio_stream_player_2d.pitch_scale *= 100 / length

func _process(delta: float) -> void:
	update_lines()
func _physics_process(delta: float) -> void:
	rotate(speed * delta)


func update_lines() -> void:
	collide_area.position.y = length
	connector_line.points = [Vector2.ZERO, collide_area.position]
	collider_line.points = collision_polygon_2d.polygon
	collider_line.position = collision_polygon_2d.position


func _on_collide_area_area_entered(area: Area2D) -> void:
	if reverse_on_hit:
		speed = -speed
	audio_stream_player_2d.play()
