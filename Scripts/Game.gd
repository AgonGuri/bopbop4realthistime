extends Node2D

#Spites animation on beat
@onready var villagers_foreground = $MainUi/VillagersForeground2
@onready var villagers_background = $MainUi/VillagersBackground

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

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

var lane = 0
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
	$Conductor.play_with_beat_offset(8)
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


func _on_conductor_measure_signal(pos):
	if pos == 1:
		_spawn_notes(spawn_1_beat)
	elif pos == 2:
		_spawn_notes(spawn_2_beat)
	elif pos == 3:
		_spawn_notes(spawn_3_beat)
	elif pos == 4:
		_spawn_notes(spawn_4_beat)

func _on_conductor_beat_signal(pos):
	song_position_in_beats = pos
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 98:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 162:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 194:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 258:
		spawn_1_beat = 1
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 288:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 322:
		spawn_1_beat = 3
		spawn_2_beat = 2
		spawn_3_beat = 2
		spawn_4_beat = 1
	if song_position_in_beats > 388:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 396:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	#if song_position_in_beats > 404:
		#Global.set_score(score)
		#Global.combo = max_combo
		#Global.great = great
		#Global.good = good
		#Global.okay = okay
		#Global.missed = missed
		if get_tree().change_scene_to_file("res://Scenes/End.tscn") != OK:
			print ("Error changing scene to End")
			
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
		lane = randi() % 3
		instance = projectile.instantiate()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 4
		lane = rand
		instance = projectile.instantiate()
		projectile.initialize(lane)
		add_child(instance)
		


func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	
	score += by * combo
	$Score.text = str(score)
	if combo > 0:
		$Combo.text = str(combo) + " combo!"
		if combo > max_combo:
			max_combo = combo
	else:
		$Combo.text = ""


func reset_combo():
	combo = 0
	$Combo.text = ""
