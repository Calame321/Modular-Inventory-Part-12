class_name Scale_Control extends Control

var ui_scale : float
var current_size

func _ready():
	SignalManager.ui_scale_changed.connect( _on_ui_scale_changed )
	resized.connect( _on_resized )
	set_ui_scale( SettingsManager.ui_scale )
	current_size = get_viewport_rect().size

# Set the scale of this control.
func set_ui_scale( value ):
	ui_scale = value
	scale = Vector2( ui_scale, ui_scale )

# Set the scale when changed.
func _on_ui_scale_changed( value ):
	set_ui_scale( value )

# When the size change, update the pivot points.
func _on_resized():
	var new_size = get_viewport_rect().size
	pivot_offset = pivot_offset / current_size * new_size
	current_size = new_size
