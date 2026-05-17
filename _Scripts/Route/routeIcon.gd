extends Area2D
class_name RouteIcon

@onready var route_sprite :Sprite2D = $RouteSprite
@onready var disabled_sprite: Sprite2D = $Disabled
@export var route_resource: RouteResource
var route_generator: RouteGenerator

var child_routes: Array[RouteIcon]
var is_root : bool = false

var is_hovered: bool = false
var is_traversable: bool = false
var is_active: bool = false
	
func init(_route_generator: RouteGenerator) -> void:
	route_sprite.texture = route_resource.route_icon
	self.route_generator = _route_generator

func evaluate_route() -> void:
	print("Evaluationg to")
	route_resource.evaluate()
	
func set_active_node() -> void:
	is_active = true
	is_traversable = false
	
	for child: RouteIcon in child_routes:
		child.is_traversable = true
		child.highlight()

func add_child_route(child_route: RouteIcon) -> void:
	child_routes.append(child_route)

func highlight() -> void:
	disabled_sprite.visible = false

func unhighlight() -> void:
	disabled_sprite.visible = true
	
func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left") and is_hovered and is_traversable: 
		route_generator.clear_active_routes()
		await route_generator.move_player_to(self)
		set_active_node()
		evaluate_route()
