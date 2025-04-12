extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var startButton = $StartButton
	startButton.pressed.connect(self._startButton_pressed)
	
	var quitButton = $QuitButton
	quitButton.pressed.connect(self._quitButton_pressed)

func _startButton_pressed():
	CutSceneManager.startedFromMenu = true
	get_tree().change_scene_to_file("res://Scenes/IntroCutscene.tscn")

func _quitButton_pressed():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	#Progress to First Cutscene
	#get_tree().change_scene_to_file("res://Scenes/CutSceneManager.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
