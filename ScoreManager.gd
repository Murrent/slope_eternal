extends Control

@onready var score_text = $score
var score: int = 0
var texts: Array
var time_since_delete: float = 0

func add_score(text: String, value: int):
	score += value
	var new_text = RichTextLabel.new()
	new_text.text = text + ": +" + str(value)
	new_text.position = score_text.position + Vector2.DOWN * (1 + texts.size()) * 20
	new_text.size.x = 200
	new_text.size.y = 40
	add_child(new_text)
	texts.push_back(new_text)
	time_since_delete = 5.0
	score_text.text = "Score: " + str(score)


func _process(delta: float) -> void:
	rotation = -get_parent().rotation
	
	time_since_delete -= delta
	if time_since_delete < 0.0:
		for text in texts:
			text.queue_free()
		texts.clear()
