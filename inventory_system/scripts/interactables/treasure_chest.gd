extends Chest

func set_items():
	pass

# For each slots, Get a new item and roll it's rarity.
func interact():
	for s in inventory.slots:
		s.put_item( null )
	
	for nb in inventory.slots.size():
		inventory.add_item( ItemManager.rng_generate_rarity( 100 ) )
	
	SignalManager.emit_signal( "inventory_opened", inventory )
