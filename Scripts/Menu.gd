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
