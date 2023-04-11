extends TextureProgressBar

@export( NodePath ) onready var lbl = get_node( lbl ) as Label

var item_usable

# Set the value of the progress.
func set_data( usable ):
	item_usable = usable
	max_value = usable.cooldown
	
	if usable.is_in_cooldown:
		value = usable.cooldown_remaining

# Update the cooldown progress.
func _process( _delta ):
	value = item_usable.cooldown_remaining
	lbl.text = "%0.2f" % item_usable.cooldown_remaining
	
	if item_usable.cooldown_remaining <= 0:
		queue_free()
