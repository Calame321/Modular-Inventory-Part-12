class_name Affix_Item extends Resource

var affix_group
var affix
var scale : float

func _init( data ):
	affix_group = ItemManager.affix_groups[ data.affix_group ]
	affix = affix_group.affixes[ data.affix ]
	scale = data.scale

func set_info( item_info, rarity ):
	for stat_range in affix.stat_ranges:
		var display = ResourceManager.stat_info[ stat_range.stat ].display
		var value = round( lerp( stat_range.minimum, stat_range.maximum, scale ) )
		var text = display % value
		item_info.add_line( Item_Info_Line.new( text, rarity ) )

func get_data():
	return {
		"affix_group": affix_group.id,
		"affix": affix.id,
		"scale": scale
	}
