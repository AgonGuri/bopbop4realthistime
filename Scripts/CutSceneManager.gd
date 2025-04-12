extends Node2D

#const Balloon = preload("res://dialogue/balloon.tscn")

var introDialogueCalled
var startedFromMenu = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.get_current_scene = func():
		return get_node(".")
	
	#var balloon: Node = Balloon.instantiate()
	#get_tree().current_scene.add_child(balloon)

	
	#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "introCutscene")
	introDialogueCalled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!introDialogueCalled and startedFromMenu):
		introDialogueCalled = true
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "introCutscene")
		
		
	#okay so this will depend on other stuff
	#like
	#if gameOver:
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "youLose")
		
		
	#if gameWon:
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "youWin")

#FOR MANAGING CUTSCENE IMAGES
#yes there are better ways to do this. no I'm not going to do them
func ShowSecondImage():
	var secondImage = get_node("/root/IntroCutscene/secondImage")
	secondImage.visible = true
	
func ShowThirdImage():
	var thirdImage = get_node("/root/IntroCutscene/thirdImage")
	thirdImage.visible = true
	
func ShowFourthImage():
	var fourthImage = get_node("/root/IntroCutscene/fourthImage")
	fourthImage.visible = true
	
func ShowFifthImage():
	var fifthImage = get_node("/root/IntroCutscene/fifthImage")
	fifthImage.visible = true
	
func ShowSixthImage():
	var sixthImage = get_node("/root/IntroCutscene/sixthImage")
	sixthImage.visible = true
	
func ShowSeventhImage():
	var seventhImage = get_node("/root/IntroCutscene/seventhImage")
	seventhImage.visible = true
	
func ShowEighthImage():
	var eighthImage = get_node("/root/IntroCutscene/eighthImage")
	eighthImage.visible = true
	
func ShowNinthImage():
	var ninthImage = get_node("/root/IntroCutscene/ninthImage")
	ninthImage.visible = true

func ShowDarkScreen():
	var darkScreen = get_node("/root/IntroCutscene/darkScreen")
	darkScreen.visible = true
	
func ShowWinFirstImage():
	get_tree().change_scene_to_file("res://Scenes/WinCutscene.tscn")
	
func ShowWinSecondImage():
	var winSecondImage = get_node("/root/WinCutscene/secondImage")
	winSecondImage.visible = true
	var audioPlayer = get_node("/root/WinCutscene/audioPlayer")
	audioPlayer.play()




func StartGame():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	#I could even do....
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "beforeGameStart")

func StartGameplay():
	var conductor = get_node("/root/Game/Conductor")
	conductor.play()
	conductor.play_with_beat_offset(8)

func GameOver():
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")

	
#and then I'll have other functions that are called at the end of youWon, gameOver
#which will call their respective scenes
#once those exist or whatever
