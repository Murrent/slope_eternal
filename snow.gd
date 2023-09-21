extends GPUParticles2D

@export var target: Node2D


func _physics_process(delta: float) -> void:
	if target != null:
		position = target.position
