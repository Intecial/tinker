extends Node2D
class_name RouteParent

@export var bounds_min: Vector2 = Vector2(-500, -500)
@export var bounds_max: Vector2 = Vector2(500, 500)

@export var root: Node

var _dragging: bool = false
var _drag_start_mouse: Vector2
var _drag_start_position: Vector2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_dragging = true
			_drag_start_mouse = get_global_mouse_position()
			_drag_start_position = root.position
		else:
			_dragging = false

	if event is InputEventMouseMotion and _dragging:
		var offset = get_global_mouse_position() - _drag_start_mouse
		var target = _drag_start_position + offset
		root.position = Vector2(
			clamp(target.x, bounds_min.x, bounds_max.x),
			clamp(target.y, bounds_min.y, bounds_max.y)
		)

func recenter() -> void:
	root.position = Vector2.ZERO
