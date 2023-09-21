extends RigidBody2D

var death_effect: PackedScene = preload("res://player_dead.tscn")

@onready var score_manager = $Control

@export var rotation_force: float = 10000
@export var jump_force: float = 20000

@export var grounded_area: Area2D 
var grounded: bool = false
var time_since_grounded: float = 0

signal dead(pos: Vector2)


func _physics_process(delta: float) -> void:
	grounded = grounded_area.has_overlapping_bodies()
	
	if !grounded:
		time_since_grounded += delta
		if Input.is_action_pressed("left"):
			apply_torque_impulse(-rotation_force * delta)
		if Input.is_action_pressed("right"):
			apply_torque_impulse(rotation_force * delta)
	else:
		if time_since_grounded > 0.5:
			score_manager.add_score("Air time", time_since_grounded * 10)
		time_since_grounded = 0
		if Input.is_action_just_pressed("jump"):
			apply_impulse(Vector2.UP * jump_force * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("dead")
	dead.emit(global_position)
	var effect = death_effect.instantiate()
	effect.global_position = global_position
	effect.global_rotation = global_rotation
	effect.get_child(2).get_child(2).text = "Score: " + str(score_manager.score)
	get_parent().add_child(effect)
	queue_free()
