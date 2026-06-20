extends Node2D
class_name RouteGenerator


@export var player_sprite: Sprite2D

@export var player_pos_offset: Vector2 = Vector2(25, 25)

@export var route_icon : PackedScene
@export var tree_height: int = 5
@export var horizontal_spacing: float = 150.0
@export var vertical_spacing: float = 150.0
@export var line_point_offset_distance: float = 50.0
@export var max_route_per_height: int = 3

var route_icons: Array[RouteIcon]

#@export
@export var encounter_routes: Array[RouteResource]
@export var misc_routes: Array[RouteResource]
var last_route: RouteIcon 

func _enter_tree() -> void:
	Constant.ROUTE_GENERATOR = self

func set_player_pos(route_icon: RouteIcon) -> void:
	player_sprite.position = route_icon.position + player_pos_offset
	
func generate_routes() -> void:
	var root: RouteIcon = create_route_icon()
	var total_misc_per_branch: int = int(tree_height / 2)
	root.position = Vector2(0, horizontal_spacing + vertical_spacing)
	root.is_root = true
	root.is_active = true
	root.set_active_node()
	root.is_traversable = true
	root.highlight()
	set_player_pos(root)
	var end_route: RouteIcon = create_route_icon()
	end_route.position = Vector2((tree_height + 2) * vertical_spacing, horizontal_spacing + vertical_spacing)
	last_route = end_route
	for i: int in range(max_route_per_height):
		var branch: RouteIcon = create_route_icon()
		var height_space: float = vertical_spacing * (i + 1)
		branch.position = Vector2(horizontal_spacing , height_space)
		var current_branch: RouteIcon = branch
		var current_node: RouteIcon = branch	
		for height: int in range(tree_height):
			var child: RouteIcon = create_route_icon()
			if total_misc_per_branch == height:
				free_icon(child)
				child = create_route_icon(false)
			child.position = Vector2((height + 2) * horizontal_spacing, height_space)
			draw_line_between_routes(current_node, child)
			current_node.add_child_route(child)
			current_node = child
		root.add_child_route(current_branch)
		draw_line_between_routes(root, current_branch)
		current_node.add_child_route(end_route)
		draw_line_between_routes(end_route, current_node)

func move_player_to(route_icon_to_go: RouteIcon) -> void:
	var target_pos : Vector2= route_icon_to_go.position + player_pos_offset
	var tween :Tween = create_tween()
	tween.tween_property(player_sprite, "position", target_pos, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished

func free_icon(child: RouteIcon) -> void:
	route_icons.erase(child)
	child.queue_free()

func clear_active_routes() -> void:
	for icon: RouteIcon in route_icons:
		icon.is_active = false
		icon.is_traversable = false
		icon.unhighlight()
			
func create_route_icon(is_encounter: bool = true) -> RouteIcon:
	var created_icon: RouteIcon = route_icon.instantiate()
	add_child(created_icon)
	if is_encounter:	
		created_icon.route_resource = encounter_routes.pick_random()
	else:
		created_icon.route_resource = misc_routes.pick_random()
	created_icon.init(self)
	route_icons.append(created_icon)
	return created_icon


func draw_line_between_routes(from: RouteIcon, to: RouteIcon) -> void:
	var line: Line2D = Line2D.new()
	add_child(line)
	line.width = 2.0
	line.default_color = Color.WHITE

	var direction: Vector2 = (to.position - from.position).normalized()
	line.add_point(from.position + direction * line_point_offset_distance)
	line.add_point(to.position - direction * line_point_offset_distance)

func regenerate() -> void:
	route_icons.clear()
	for child: Node in get_children():
		child.queue_free()
	
	generate_routes()
	
func is_last_route() -> bool:
	return last_route.is_active
