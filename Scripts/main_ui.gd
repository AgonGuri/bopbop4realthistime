extends Node2D

#Making the villagers bounce
@onready var villager_bg = $TextureRect/VillagersBackground
@onready var villager_fg = $VillagersForeground

#aaa
var beat_timer = 0.0
const BPM = 90  # Set your song's BPM
var beat_interval = 45.0 / BPM
var pulse_up = true

func _ready():
	villager_bg.scale = Vector2.ONE

func _process(delta):
	beat_timer += delta
	if beat_timer >= beat_interval:
		beat_timer -= beat_interval
		pulse()

func pulse():
	# Alternate between pulsing up and returning to normal
	if pulse_up:
		villager_bg.scale.x = 0.95
		villager_bg.scale.y = 1.05
		villager_fg.scale.x = 1.05
		villager_fg.scale.y = 0.95
		
		
	else:
		villager_bg.scale = Vector2.ONE
		villager_fg.scale = Vector2.ONE
	pulse_up = !pulse_up
