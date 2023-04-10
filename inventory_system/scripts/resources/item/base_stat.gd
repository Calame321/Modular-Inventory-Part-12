class_name Base_stat extends Resource

var stat_ranges = []
var scale : float = 0

func _init( data ):
	for stat_range in data:
		stat_ranges.append( Stat_Range.new( stat_range ) )

func set_info( item_info ):
	item_info.add_splitter()
	
	for stat_range in stat_ranges:
		var display = ResourceManager.stat_info[ stat_range.stat ].display
		var value = stat_range.get_value( scale, stat_range.stat )
		var text = display % value
		item_info.add_line( Item_Info_Line.new( text, Game_Enums.RARITY.NORMAL ) )

func get_data() -> float:
	return scale

func get_stat( stat ):
	var total = 0
	for stat_range in stat_ranges:
		total += stat_range.get_value( scale, stat )
	return total
