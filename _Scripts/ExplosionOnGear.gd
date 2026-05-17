extends GPUParticles2D
class_name ExplosionOnGear

func _ready() -> void:
	emitting = false
	one_shot = true
	explosiveness = 1.0
	amount = 16
	lifetime = 0.5
	
	var particle_proc_mat : ParticleProcessMaterial = ParticleProcessMaterial.new()
	particle_proc_mat.direction = Vector3(0, 0, 0)
	particle_proc_mat.spread = 180.0
	particle_proc_mat.initial_velocity_min = 50.0
	particle_proc_mat.initial_velocity_max = 150.0
	particle_proc_mat.gravity = Vector3(0, 0, 0)
	particle_proc_mat.scale_min = 4.0
	particle_proc_mat.scale_max = 8.0
	process_material = particle_proc_mat

func burst(color: Color = Color.WHITE) -> void:
	(process_material as ParticleProcessMaterial).color = color
	restart()
	emitting = true