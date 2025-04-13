extends AnimatedSprite2D

var blocked = false
var perfect = false
var great = false
var ok = false

# Queue for projectiles
var current_projectile_array = []

@export var input = ""

func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			# Check if there's a projectile in the queue
			if current_projectile_array.size() > 0:
				# Remove the first projectile from the queue and process it
				var projectile = current_projectile_array.pop_front()
				if perfect:
					get_parent().get_parent().increment_score(3)
					projectile.destroy(3)
					blocked = true
				elif great:
					get_parent().get_parent().increment_score(2)
					projectile.destroy(2)
					blocked = true
				elif ok:
					get_parent().get_parent().increment_score(1)
					projectile.destroy(1)
					blocked = true
				_reset()
			else:
				get_parent().get_parent().increment_score(0)
		if event.is_action_pressed(input):
			frame = 1       # animating the button press
		if event.is_action_released(input):
			$PushTimer.start()

func _on_PushTimer_timeout():
	frame = 0       # animating the button release

func _reset():
	# Reset flags for next projectile
	perfect = false
	great = false
	ok = false

# When a projectile enters the ok area, add it to the queue
func _on_ok_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		ok = true
		if area not in current_projectile_array:
			current_projectile_array.append(area)

# When the projectile leaves the ok area, remove it from the queue if still present
func _on_ok_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		ok = false
		if area in current_projectile_array:
			current_projectile_array.erase(area)
		if blocked == false:
			get_parent().get_parent().increment_score(4)
		blocked = false

# Set the perfect flag when projectile is in the perfect area
func _on_perfect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		perfect = true

func _on_perfect_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		perfect = false

# Set the great flag when projectile is in the great area
func _on_great_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		great = true

func _on_great_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		great = false
