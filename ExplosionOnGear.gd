extends GPUParticles2D
class_name ExplosionOnGear

func _ready() -> void:
	emitting = false
	one_shot = true
	explosiveness = 1.0
	amount = 16
	lifetime = 0.5
	
	var material := ParticleProcessMaterial.new()
	material.direction = Vector3(0, 0, 0)
	material.spread = 180.0
	material.initial_velocity_min = 50.0
	material.initial_velocity_max = 150.0
	material.gravity = Vector3(0, 0, 0)
	material.scale_min = 4.0
	material.scale_max = 8.0
	process_material = material

func burst(color: Color = Color.WHITE) -> void:
	(process_material as ParticleProcessMaterial).color = color
	restart()
	emitting = true