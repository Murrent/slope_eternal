extends Control

func _ready() -> void:
	rotation = -get_parent().rotation


func _on_button_button_up() -> void:
	get_tree().reload_current_scene()
