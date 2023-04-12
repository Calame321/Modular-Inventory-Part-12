class_name Dragable_Control extends Control

@export var safe_zone : int = 30

var dragging : bool = false
var offset : Vector2

func _ready():
	get_viewport().connect("size_changed", Callable(self, "_on_size_changed"))

# If the mouse is moving and currently dragging, move the control.
func _input( event ):
	if event is InputEventMouseMotion and dragging:
		set_pos( event.position - offset )

# Change the scale, but keep the control in the screen.
func set_ui_scale( value ):
	await get_tree().idle_frame
	set_pos( position )

# Set the position of the control, but keep it in the screen.
func set_pos( pos ):
	var scaled_size = size * scale
	var screen_size = get_viewport().get_visible_rect().size
	pos.x = clamp( pos.x, -scaled_size.x + safe_zone, screen_size.x - safe_zone )
	pos.y = clamp( pos.y, -scaled_size.y + safe_zone, screen_size.y - safe_zone )
	position = pos

# If left clicking on the control, start dragging.
func _gui_input( event : InputEvent ):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		offset = event.global_position - position
		dragging = event.pressed
		move_to_front()

# If the size change, make sure it's still in the screen.
func _on_size_changed():
	set_pos( position )



