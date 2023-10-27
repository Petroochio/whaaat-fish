extends Label

@export var preface: String = "P1"
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    text = preface + " "
    text += str(score)
    pass # Replace with function body.
    
func add_score(amt):
    score += amt
    text = preface + " "
    text += str(score)
    pass
