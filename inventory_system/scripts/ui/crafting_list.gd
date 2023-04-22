extends UiWindow

func _ready():
	super()
	SignalManager.crafting_opened.connect( _on_crafting_opened )
	SignalManager.crafting_out_of_range.connect( _on_crafting_out_of_range )

# Display the list of recipes.
func display( recipes ):
	for c in %recipe_list.get_children():
		%recipe_list.remove_child( c )
		c.queue_free()
	
	for recipe_id in recipes:
		var recipe_node = ResourceManager.get_instance( "crafting_option" )
		%recipe_list.add_child( recipe_node )
		recipe_node.set_info( recipe_id, recipes[ recipe_id ].price, recipes[ recipe_id ].produce )
	
	show()
	size = Vector2( 140, 0 )

# When closed, set the shop opened to false.
func close():
	super.close()
	InventoryManager.is_shop_open = false

# When opened, display the ui, and if it's a shop, allow selling.
func _on_crafting_opened( list_id ):
	display( ResourceManager.get_recipes( list_id ) )
	if list_id == "shop":
		InventoryManager.is_shop_open = true

# When out of range, close the window.
func _on_crafting_out_of_range():
	close()
