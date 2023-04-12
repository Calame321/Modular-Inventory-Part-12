extends Area2D

@export var item_id : String

var item : Item
var action = "pickup"
var object_name = ""

func _ready():
	if not item:
		item = ItemManager.get_item( item_id )
	object_name = item.name

# Try to pick up the item.
# Remove it if possible.
func interact():
	if InventoryManager.has_space_for_items( [ item.get_data() ], "player" ):
		InventoryManager.add_items( [ item ], "player" )
		queue_free()
