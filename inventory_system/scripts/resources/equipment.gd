class_name Equipment extends Inventory

# Sets the slots and attach signals.
func _init():
	slots.append( Equipment_Slot.new( 0, self, Game_Enums.EQUIPMENT_TYPE.HEAD ) )
	slots.append( Equipment_Slot.new( 1, self, Game_Enums.EQUIPMENT_TYPE.CHEST ) )
	slots.append( Equipment_Slot.new( 2, self, Game_Enums.EQUIPMENT_TYPE.OFFHAND ) )
	slots.append( Equipment_Slot.new( 3, self, Game_Enums.EQUIPMENT_TYPE.MAIN_HAND ) )
	
	for slot in slots:
		slot.connect( "item_changed", self, "_on_item_changed" )

# Get the total of the given stat from all equipped items.
func get_stat( stat ):
	var total = 0
	for slot in slots:
		total += slot.get_stat( stat )
	return total
