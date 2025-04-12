extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var startButton = $CanvasLayer/Control/VBoxContainer/StartButton
	startButton.pressed.connect(self._on_start_button_pressed)
	
	var quitButton = $CanvasLayer/Control/VBoxContainer/QuitButton
	quitButton.pressed.connect(self._on_quit_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	CutSceneManager.startedFromMenu = true
	get_tree().change_scene_to_file("res://Scenes/IntroCutscene.tscn")



func _on_quit_button_pressed() -> void:
	get_tree().quit()
