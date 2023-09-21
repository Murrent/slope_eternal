extends Node2D

@export var player: Node2D
@onready var slopes = [preload("res://default_slope.tscn"), preload("res://ramp_slope.tscn"), preload("res://steeper_slope.tscn")]
var last_connector: Vector2 = Vector2(-1500,0)

func _ready() -> void:
	for i in range(1):
		generate()

func generate(): 
	var slope = randi_range(0, slopes.size() - 1)
	var new_slope: PackedScene = slopes[slope]
	var slope_inst: StaticBody2D = new_slope.instantiate()
	var connector: Node2D = slope_inst.get_child(2)
	slope_inst.global_position = last_connector + Vector2.DOWN * 1
	
	last_connector = slope_inst.position + connector.position
	add_child(slope_inst)

func _physics_process(delta: float) -> void:
	if player == null:
		return
	var diff = player.position.x - last_connector.x
	if abs(diff) < 10000:
		generate()
