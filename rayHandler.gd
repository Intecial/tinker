class_name RayHandler
extends Node3D

@export var collision_mask: int = 1

var _camera: Camera3D
var _current_hittable: IHittable = null

func _ready() -> void:
	_camera = get_viewport().get_camera_3d()

func _process(_delta: float) -> void:
	_get_selected_position()
	_handle_input()

func _handle_input() -> void:
	if _current_hittable != null:
		_current_hittable.HandleInput()

func _get_selected_position() -> void:
	var mouse_pos := get_viewport().get_mouse_position()
	var origin := _camera.project_ray_origin(mouse_pos)
	var end := origin + _camera.project_ray_normal(mouse_pos) * 1000.0
	
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = collision_mask
	query.collide_with_areas = true
	

	var result := get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		_clear_hittable()
		return

	var hit_object := result["collider"] as Node
	var hittable := hit_object.get_node_or_null("IHittable") as IHittable
	if hittable:
		if hittable != _current_hittable:
			_clear_hittable()
			_current_hittable = hittable
		_current_hittable.Hit()
	else:
		_clear_hittable()

func _clear_hittable() -> void:
	if _current_hittable != null:
		_current_hittable.OnRayExit()
		_current_hittable = null

func get_placement_input() -> bool:
	return Input.is_action_just_pressed("click")
