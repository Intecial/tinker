extends Node
class_name ActorContext

var data : Dictionary[String, Variant] = {

}

var actor: Actor

func init(init_actor: Actor) -> void:
	actor = init_actor

func try_get_data(key: String) -> Variant:
	if data.find_key(key):
		return data.get(key)
	return false

func set_data(key: String, value: Variant) -> void:
	data.set(key, value)
	
func remove_data(key: String) -> void:
	if try_get_data(key):
		data.erase(key)
	