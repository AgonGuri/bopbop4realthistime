extends Node2D

#const Balloon = preload("res://dialogue/balloon.tscn")

var introDialogueCalled
var startedFromMenu = false

#var happyVillageTheme
#var villainChord
#var menacingTheme
#var victoryTheme

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.get_current_scene = func():
		return get_node(".")
	#happyVillageTheme = get_tree().get_root().get_node("/Scenes/IntroCutscene/HappyVillageTheme")
	#villainChord = get_node("/root/IntroCutscene/VillainChord")
	#menacingTheme = get_node("/root/IntroCutscene/MenacingTheme")
	#victoryTheme = get_node("/root/IntroCutscene/VictoryTheme")
	#
	#var balloon: Node = Balloon.instantiate()
	#get_tree().current_scene.add_child(balloon)

	
	#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "introCutscene")
	introDialogueCalled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!introDialogueCalled and startedFromMenu):
		introDialogueCalled = true
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "introCutscene")
		$HappyVillageTheme.play()
		
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
	$HappyVillageTheme.stop()
	$VillainChord.play()
	$MenacingTheme.play()
	
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
	$VictoryTheme.play()
	
func ShowNinthImage():
	var ninthImage = get_node("/root/IntroCutscene/ninthImage")
	ninthImage.visible = true

func ShowDarkScreen():
	var darkScreen = get_node("/root/IntroCutscene/darkScreen")
	darkScreen.visible = true
	$MenacingTheme.stop()
	
func ShowWinFirstImage():
	get_tree().change_scene_to_file("res://Scenes/WinCutscene.tscn")
	
func ShowWinSecondImage():
	var winSecondImage = get_node("/root/WinCutscene/secondImage")
	winSecondImage.visible = true
	var audioPlayer = get_node("/root/WinCutscene/audioPlayer")
	audioPlayer.play()

func ShowCredits():
	var credits = get_node("/root/WinCutscene/secondImage/bg/Credits")
	var credits2 = get_node("/root/WinCutscene/secondImage/Credits2")
	
	var bg = get_node("/root/WinCutscene/secondImage/bg")
	var bg2 = get_node("/root/WinCutscene/secondImage/bg2")
	
	var startButton =  get_node("/root/WinCutscene/secondImage/StartButton")
	var quitButton =  get_node("/root/WinCutscene/secondImage/QuitButton")

	
	#would be much nicer to fade these in
	credits.visible = true
	credits2.visible = true
	bg.visible = true
	bg2.visible = true
	
	startButton.visible = true
	quitButton.visible = true
	
	credits.modulate.a = 0
	credits2.modulate.a = 0
	bg.modulate.a = 0
	bg2.modulate.a = 0
	
	startButton.modulate.a = 0
	quitButton.modulate.a = 0
	
	var tween1 = get_tree().create_tween()
	tween1.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween1.tween_property(credits, "modulate:a", 1, 8)

	var tween2 = get_tree().create_tween()
	tween2.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween2.tween_property(credits2, "modulate:a", 1, 8)
	
	
	var tween3 = get_tree().create_tween()
	tween3.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween3.tween_property(bg, "modulate:a", 1, 8)
	
	var tween4 = get_tree().create_tween()
	tween4.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween4.tween_property(bg2, "modulate:a", 1, 8)
	
	var tween5 = get_tree().create_tween()
	tween5.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween5.tween_property(startButton, "modulate:a", 0.7, 8)
	
	var tween6 = get_tree().create_tween()
	tween6.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween6.tween_property(quitButton, "modulate:a", 0.7, 8)
	
	






func StartGame():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	#I could even do....
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "beforeGameStart")
	
func StartGameplay():
	var conductor = get_node("/root/Game/Conductor")
	conductor.play()
	conductor.play_with_beat_offset(8)
	$VictoryTheme.stop()

func GameOver():
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")


func GameWon():
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "youWin")

	
#and then I'll have other functions that are called at the end of youWon, gameOver
#which will call their respective scenes
#once those exist or whatever
