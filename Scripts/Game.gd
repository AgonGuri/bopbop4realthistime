extends Node2D

#Spites animation on beat
@onready var villagers_foreground = $MainUi/VillagersForeground2
@onready var villagers_background = $MainUi/VillagersBackground

#Animating the characters
@onready var bopbop = $MainUi/BopBop2
@onready var evil_wizard = $MainUi/EvilWizard2

#Animation parameters
var pulse_scale_x = 1
var pulse_scale_y = 1
var base_scale: Vector2

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 180

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0
var spawn_5_beat = 0
var spawn_6_beat = 0
var spawn_7_beat = 0
var spawn_8_beat = 0
var spawn_9_beat = 0
var spawn_10_beat = 0
var spawn_11_beat = 0
var spawn_12_beat = 0
var spawn_13_beat = 0
var spawn_14_beat = 0
var spawn_15_beat = 0
var spawn_16_beat = 0

var progress = 0

var lane = randi() % 4
var rand = 0
var projectile = load("res://Scenes/Projectile.tscn")
var instance

const POS_X = 400
var LANE_WIDTH = 1080 / 6 # split the screen in 6 lanes and use the middle 4 for the projectiles
var FIRST_LANE_SPAWN = Vector2(POS_X, LANE_WIDTH * 1)
var SECOND_LANE_SPAWN = Vector2(POS_X, LANE_WIDTH * 2)
var THIRD_LANE_SPAWN = Vector2(POS_X, LANE_WIDTH * 3)
var FOURTH_LANE_SPAWN = Vector2(POS_X, LANE_WIDTH * 4)

func _ready():
	randomize()
	$ArrowOverlays/ArrowUP.position = FIRST_LANE_SPAWN
	$ArrowOverlays/ArrowRIGHT.position = SECOND_LANE_SPAWN
	$ArrowOverlays/ArrowLEFT.position = THIRD_LANE_SPAWN
	$ArrowOverlays/ArrowDOWN.position = FOURTH_LANE_SPAWN
	
	#for the animation
	base_scale = villagers_foreground.scale
	
	
	

func _input(event):
	if event.is_action("escape"):
		if get_tree().change_scene_to_file("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")
			
	#Bopop animation manager
	if event.is_action("up"):
		bopbop.play("defend_up")
		jump_animation()
	if event.is_action("down"):
		bopbop.play("defend_down")
		jump_animation()
	if event.is_action("left"):
		bopbop.play("defend_left")
		jump_animation()
	if event.is_action("right"):
		bopbop.play("defend_right")
		jump_animation()

#Bopbop jumping when input = true
func jump_animation():
	var start_pos = Vector2(301, 978)
	var jump_height = -5  # pixels to move up
	var jump_time = 0.1  # seconds up and down
	#Tween animation
	var tween_jump = get_tree().create_tween()
	tween_jump.tween_property(bopbop, "position", start_pos + Vector2(0, jump_height), jump_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_jump.tween_property(bopbop, "position", start_pos, jump_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


func _on_conductor_measure_signal(pos):
	if pos == 1:
		_spawn_notes(spawn_1_beat)
	elif pos == 2:
		_spawn_notes(spawn_2_beat)
	elif pos == 3:
		_spawn_notes(spawn_3_beat)
	elif pos == 4:
		_spawn_notes(spawn_4_beat)
	elif pos == 5:
		_spawn_notes(spawn_5_beat)
	elif pos == 6:
		_spawn_notes(spawn_6_beat)
	elif pos == 7:
		_spawn_notes(spawn_7_beat)
	elif pos == 8:
		_spawn_notes(spawn_8_beat)
	elif pos == 9:
		_spawn_notes(spawn_9_beat)
	elif pos == 10:
		_spawn_notes(spawn_10_beat)
	elif pos == 11:
		_spawn_notes(spawn_11_beat)
	elif pos == 12:
		_spawn_notes(spawn_12_beat)
	elif pos == 13:
		_spawn_notes(spawn_13_beat)
	elif pos == 14:
		_spawn_notes(spawn_14_beat)
	elif pos == 15:
		_spawn_notes(spawn_15_beat)
	elif pos == 16:
		_spawn_notes(spawn_16_beat)

func _on_conductor_beat_signal(pos):
	song_position_in_beats = pos
	if song_position_in_beats > 24:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 0
		spawn_8_beat = 0
		#these will always be zero for player response
		spawn_9_beat = 0
		spawn_10_beat = 0
		spawn_11_beat = 0
		spawn_12_beat = 0
		spawn_13_beat = 0
		spawn_14_beat = 0
		spawn_15_beat = 0
		spawn_16_beat = 0
	if song_position_in_beats > 56:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 0
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 88:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 1
		spawn_5_beat = 0
		spawn_6_beat = 1
		spawn_7_beat = 0
		spawn_8_beat = 0
	if song_position_in_beats > 120:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 1
		spawn_7_beat = 0
		spawn_8_beat = 0
	if song_position_in_beats > 152:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 1
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 184:
		#change speed of arrows for 2 beat delay
		#in theory.
		#in practice we probably don't have time to set it up right
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 216:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 0
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 248:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 1
		spawn_5_beat = 0
		spawn_6_beat = 1
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 280:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 1
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 312:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 1
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 344:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
		spawn_5_beat = 0
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 376:
		#hard section begins
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 408:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 0
	if song_position_in_beats > 440:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 1
		spawn_8_beat = 1
	if song_position_in_beats > 472:
		spawn_1_beat = 0
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 1
		spawn_5_beat = 0
		spawn_6_beat = 1
		spawn_7_beat = 0
		spawn_8_beat = 1
	if song_position_in_beats > 504:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
		spawn_5_beat = 1
		spawn_6_beat = 1
		spawn_7_beat = 1
		spawn_8_beat = 1
	if song_position_in_beats > 536:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 1
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 0
		spawn_8_beat = 1
	if song_position_in_beats > 568:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 0
		spawn_6_beat = 1
		spawn_7_beat = 1
		spawn_8_beat = 1
	if song_position_in_beats > 600:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
		spawn_5_beat = 1
		spawn_6_beat = 0
		spawn_7_beat = 0
		spawn_8_beat = 0
	if song_position_in_beats > 615:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
		spawn_5_beat = 0
		spawn_6_beat = 0
		spawn_7_beat = 0
		spawn_8_beat = 0
		
		#we've reached the end of the song, so if we're still alive, trigger success
		CutSceneManager.GameWon()
		$Conductor.stop()
		
	#if song_position_in_beats > 404:
		#Global.set_score(score)
		#Global.combo = max_combo
		#Global.great = great
		#Global.good = good
		#Global.okay = okay
		#Global.missed = missed
		#if get_tree().change_scene_to_file("res://Scenes/End.tscn") != OK:
			#print ("Error changing scene to End")
			
	if song_position_in_beats % 2 == 0: #villagers should bound on quarters not eighths
		#Animation of the sprites
		villagers_foreground.scale.x = pulse_scale_x
		villagers_foreground.scale.y = pulse_scale_y
		
		var pulse_scale = Vector2(pulse_scale_x, pulse_scale_y)

		# Tween: squash and stretch, then go back
		var tween1 = get_tree().create_tween()
		tween1.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		tween1.tween_property(villagers_foreground, "scale", pulse_scale, 0.02)
		tween1.tween_property(villagers_foreground, "scale", base_scale, 0.1).set_delay(0.05)
		
		var tween2 = get_tree().create_tween()
		tween2.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		tween2.tween_property(villagers_background, "scale", pulse_scale, 0.02)
		tween2.tween_property(villagers_background, "scale", base_scale, 0.1).set_delay(0.05)



func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % 4
		instance = projectile.instantiate()
		instance.initialize(lane)
		add_child(instance)
		#Play animation for the evil wizard
		evil_wizard.play("attack")
		
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 4
		lane = rand
		instance = projectile.instantiate()
		instance.initialize(lane)
		add_child(instance)
		


func increment_score(by): #Update Progress Bar
	if by == 0:
		progress = progress+5
	elif by == 1:
		progress = progress
	elif by == 2:
		progress = progress-2
	elif by == 3:
		progress = progress-4
	elif by == 4:
		progress = progress+10
	progress = clamp(progress, 0, 100)
	get_node("ProgressBar").value = progress
	
	
	if progress == 100:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
		spawn_5_beat = 0
		spawn_6_beat = 0
		spawn_7_beat = 0
		spawn_8_beat = 0
		CutSceneManager.GameOver()
	#if by > 0:
		#combo += 1
	#else:
		#combo = 0
	#
	#if by == 3:
		#great += 1
	#elif by == 2:
		#good += 1
	#elif by == 1:
		#okay += 1
	#else:
		#missed += 1
	#
	#
	#score += by * combo
	#$Score.text = str(score)
	#if combo > 0:
		#$Combo.text = str(combo) + " combo!"
		#if combo > max_combo:
			#max_combo = combo
	#else:
		#$Combo.text = ""
#
#
func reset_combo():
	combo = 0
	$Combo.text = ""
