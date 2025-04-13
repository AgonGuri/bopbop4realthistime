extends Area2D

#projectile stuff
const TARGET_X = 300  # set this number as an x value on arrow overlays
const BEHIND_TARGET = 100 #this is where a projectile has to be to hit the player
const SPAWN_X = 1350 # wherever we want to spawn the projectiles
const DIST_TO_TARGET = TARGET_X - SPAWN_X

var LANE_WIDTH = 1080 / 16 # split the screen in 6 lanes and use the middle 4 for the projectiles
var FIRST_LANE_SPAWN = Vector2(SPAWN_X, LANE_WIDTH * 2)
var SECOND_LANE_SPAWN = Vector2(SPAWN_X, LANE_WIDTH * 4)
var THIRD_LANE_SPAWN = Vector2(SPAWN_X, LANE_WIDTH * 6)
var FOURTH_LANE_SPAWN = Vector2(SPAWN_X, LANE_WIDTH * 8)

var speed = 0
var hit = false


func _ready():
	$SpawnSFX.play()
	pass

#projectile functions
func _physics_process(delta):
	if !hit:
		position.x += speed * delta
		if position.x < BEHIND_TARGET:
			destroy(0)
			get_parent().reset_combo()
	else:
		$Node2D.position.y -= speed * delta

func initialize(lane):
	if lane == 0:
		#TODO: change spells
		position = FIRST_LANE_SPAWN
	elif lane == 1:
		position = SECOND_LANE_SPAWN
	elif lane == 2:
		position = THIRD_LANE_SPAWN
	elif lane == 3:
		position = FOURTH_LANE_SPAWN
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	
	speed = DIST_TO_TARGET / 2.0


func destroy(score):
	$GPUParticles2D.emitting = true
	$Sprite2D.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "PERFECT"
		#$Node2D/Label.size = 60
		$Node2D/Label.modulate = Color("77CF00")
		$HitSFX.play()
	elif score == 2:
		$Node2D/Label.text = "GREAT"
		#$Node2D/Label.size = 60
		$Node2D/Label.modulate = Color("779F00")
		$HitSFX.play()
	elif score == 1:
		$Node2D/Label.text = "OK"
		#$Node2D/Label.size = 60
		$Node2D/Label.modulate = Color("f2ad00")
		$HitSFX.play()
	elif score == 0:
		$Node2D/Label.text = "BOOOH"
		#$Node2D/Label.size = 60
		$Node2D/Label.modulate = Color("FF0000")

#projectile stuff ends here



func _on_timer_timeout():
	queue_free()
