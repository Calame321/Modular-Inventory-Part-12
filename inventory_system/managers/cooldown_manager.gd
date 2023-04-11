extends Node

# All usable currently in cooldown.
var cooldowns = []

# Connect to cooldown_started signals.
func _ready():
	SignalManager.connect("cooldown_started", Callable(self, "_on_cooldown_started"))

# Count down all active cooldown and turn them off when done.
func _process( delta ):
	if cooldowns.size() > 0:
		for usable in cooldowns:
			usable.cooldown_remaining -= delta

	for usable in cooldowns:
		if usable.cooldown_remaining <= 0:
			usable.is_in_cooldown = false
			cooldowns.erase( usable )

# When a cooldown is activated, add the usable the the list.
func _on_cooldown_started( value ):
	if cooldowns.find( value ) == -1:
		cooldowns.append( value )
