extends Node2D

@onready var connector_line: Line2D = $ConnectorLine
@onready var collide_area: Area2D = $CollideArea
@onready var collision_polygon_2d: CollisionPolygon2D = $CollideArea/CollisionPolygon2D
@onready var collider_line: Line2D = $CollideArea/ColliderLine
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $CollideArea/AudioStreamPlayer2D



@export var sample : AudioStream = preload("res://sine1.sfxr")
@export var length : float = 10
@export var speed : float = 10
@export var reverse_on_hit : bool = true
@export var start_vector : Vector2 = Vector2(0, -1)

@export var length_determines_pitch : bool = true

var dragging : bool = false

func _ready() -> void:
	audio_stream_player_2d.stream = sample
	if length_determines_pitch:
		audio_stream_player_2d.pitch_scale *= 100 / length
	collide_area.position = length * start_vector.normalized()
	update_lines()

func _process(delta: float) -> void:
	
	update_lines()


func _physics_process(delta: float) -> void:
	if dragging:
		collide_area.position = get_local_mouse_position()
		collide_area.rotation = position.angle_to_point(collide_area.position.rotated(deg_to_rad(90)))
	else:
		rotate(speed * delta)


func update_lines() -> void:
	connector_line.points = [Vector2.ZERO, collide_area.position]
	collider_line.points = collision_polygon_2d.polygon
	collider_line.position = collision_polygon_2d.position
	

func _on_collide_area_area_entered(area: Area2D) -> void:
	if reverse_on_hit:
		speed = -speed
	audio_stream_player_2d.play()


func _on_collide_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		
		if event.pressed:
			dragging = true
		if !event.pressed:
			
			
			print(speed)
			dragging = false

	
