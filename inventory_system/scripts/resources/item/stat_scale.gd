class_name Stat_Scale extends Resource

var stat_range : Stat_Range
var scale : float

func _init( data, value ):
	stat_range = Stat_Range.new( data )
	scale = value

func set_info( item_info, color_id ):
	var display = ResourceManager.stat_info[ stat_range.stat ].display
	var value = stat_range.get_value( scale, stat_range.stat )
	var text = display % value
	item_info.add_line( Item_Info_Line.new( text, color_id ) )

func get_stat( stat ):
	return stat_range.get_value( scale, stat )
