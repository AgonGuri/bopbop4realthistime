extends Area2D

var perfect = false
var great = false
var ok = false
var current_note = null


@export var input = ""


func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_note != null:
				if perfect:
					get_parent().increment_score(3)
					current_note.destroy(3)
				elif great:
					get_parent().increment_score(2)
					current_note.destroy(2)
				elif ok:
					get_parent().increment_score(1)
					current_note.destroy(1)
				_reset()
			else:
				get_parent().increment_score(0)
		#if event.is_action_pressed(input):
			#frame = 1           #idk what frame is supposed to be
		elif event.is_action_released(input):
			$PushTimer.start()


func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		perfect = true


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		perfect = false


func _on_GreatArea_area_entered(area):
	if area.is_in_group("note"):
		great = true


func _on_GreatArea_area_exited(area):
	if area.is_in_group("note"):
		great = false


func _on_OkArea_area_entered(area):
	if area.is_in_group("note"):
		ok = true
		current_note = area


func _on_OkArea_area_exited(area):
	if area.is_in_group("note"):
		ok = false
		current_note = null


#func _on_PushTimer_timeout():
	#frame = 0 #idk what frame is supposed to be


func _reset():
	current_note = null
	perfect = false
	great = false
	ok = false
