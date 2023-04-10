class_name Affix_Item_List extends Resource

var affixes = [] # Affix_Item
var rarity # Game_enums.RARITY

func _init( data, item_rarity ):
	rarity = item_rarity
	
	for affix_item_data in data:
		affixes.append( Affix_Item.new( affix_item_data ) )


func set_info( item_info ):
	item_info.add_splitter()
	for affix_item in affixes:
		affix_item.set_info( item_info, rarity )
