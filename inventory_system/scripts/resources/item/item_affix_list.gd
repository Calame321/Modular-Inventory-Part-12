class_name Item_Affix_List extends Resource

var affixes = [] # Affix_Item
var rarity

func _init( data, item_rarity ):
	rarity = item_rarity
	
	for affix_item_data in data:
		affixes.append( Affix_Item.new( affix_item_data ) )

func set_info( item_info ):
	item_info.add_splitter()
	for affix_item in affixes:
		affix_item.set_info( item_info, rarity )

func get_data() -> Array:
	var data = []
	for affix_item in affixes:
		data.append( affix_item.get_data() )
	return data

func get_stat( stat ):
	var total = 0
	for affix_item in affixes:
		for stat_range in affix_item.affix.stat_ranges:
			total += stat_range.get_value( affix_item.scale, stat )
	return total
