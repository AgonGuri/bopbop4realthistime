extends Node2D

var introDialogueCalled

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.get_current_scene = func():
		return get_node(".")
	
	#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "introCutscene")
	introDialogueCalled = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!introDialogueCalled):
		introDialogueCalled = true
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "introCutscene")
		
		
	#okay so this will depend on other stuff
	#like
	#if gameOver:
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "youLose")
		
		
	#if gameWon:
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "youWin")


func StartGame():
	print("hello")
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	#I could even do....
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "beforeGameStart")
	
	
#and then I'll have other functions that are called at the end of youWon, gameOver
#which will call their respective scenes
#once those exist or whatever
