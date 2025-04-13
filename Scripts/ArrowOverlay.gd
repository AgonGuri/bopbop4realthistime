extends AnimatedSprite2D

var perfect = false
var great = false
var ok = false
var current_projectile = null
var blocked = false
#var frame = null


@export var input = ""


func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_projectile != null:
				if perfect:
					get_parent().get_parent().increment_score(3)
					current_projectile.destroy(3)
					blocked = true
				elif great:
					get_parent().get_parent().increment_score(2)
					current_projectile.destroy(2)
					blocked = true
				elif ok:
					get_parent().get_parent().increment_score(1)
					current_projectile.destroy(1)
					blocked = true
				_reset()
			else:
				get_parent().get_parent().increment_score(0)
		if event.is_action_pressed(input):
				frame = 1       #animating the butts
		if event.is_action_released(input):
			$PushTimer.start()



func _on_PushTimer_timeout():
	frame = 0       #animating the butts


func _reset():
	current_projectile = null
	perfect = false
	great = false
	ok = false


func _on_ok_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		ok = true
		current_projectile = area

func _on_ok_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		ok = false
		current_projectile = null
		if blocked == false:
			get_parent().get_parent().increment_score(4)
		blocked = false

func _on_perfect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		perfect = true

func _on_perfect_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		perfect = false

func _on_great_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		great = true

func _on_great_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		great = false
