# Attach this script to the HUD (Control) node
extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta):
	# Update the FPS label with the current FPS
	$FPSLabel.text = "FPS: " + str(Engine.get_frames_per_second())
