extends Control
@onready var title_bar: PanelContainer = $PanelContainer/VBoxContainer/MarginContainer/TitleBar
@onready var content: VBoxContainer = $PanelContainer/VBoxContainer/MarginContainer2/Content


var dragging : bool = false
var cursor_offset : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if dragging:
		title_bar.modulate.v = 1.25
		position = get_global_mouse_position() - cursor_offset
	else:
		title_bar.modulate.v = 1

func _on_title_bar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
	if event is InputEventMouseButton:
		cursor_offset = get_local_mouse_position()
		dragging = true if event.pressed else false
