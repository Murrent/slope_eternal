extends Polygon2D


func _ready() -> void:
	var poly := CollisionPolygon2D.new()
	poly.polygon = polygon
	poly.position = position
	get_parent().add_child(poly)
	
	print("poly created")
