class_name Split_Stack extends Scale_Control

signal stack_splitted

@export ( NodePath ) onready var qty_slider = get_node( qty_slider ) as HSlider
@export ( NodePath ) onready var lbl_original = get_node( lbl_original ) as Label
@export ( NodePath ) onready var lbl_new = get_node( lbl_new ) as Label
@export ( NodePath ) onready var popup = get_node( popup ) as Popup

var quantity
var new_quantity
var inventory_slot

# Show the split window, starting at half the stack.
func display( slot_node ):
	quantity = slot_node.slot.item.quantity
	inventory_slot = slot_node
	qty_slider.max_value = quantity - 1
	qty_slider.min_value = 1
	qty_slider.step = 1
	qty_slider.value = int( round( quantity / 2 ) )
	set_labels()
	show()
	popup.popup()

# set the quantity in the labels.
func set_labels():
	lbl_original.text = str( qty_slider.value )
	new_quantity = quantity - qty_slider.value
	lbl_new.text = str( new_quantity )

# Close the ui.
func _on_close_pressed():
	hide()

# Update the quantity when changed.
func _on_quantity_slider_value_changed( _value ):
	set_labels()

# Send the signal with quantity to be splitted.
func _on_btn_split_pressed():
	emit_signal( "stack_splitted", inventory_slot, new_quantity )
	hide()

# Hide the popup.
func _on_split_stack_hide():
	popup.hide()
