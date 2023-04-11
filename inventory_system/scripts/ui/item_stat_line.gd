class_name Item_Info_Line extends Label

func _init( value, color ):
	text = value
	align = Label.ALIGNMENT_CENTER
	valign = Label.VALIGN_CENTER
	set( "theme_override_fonts/font", ResourceManager.fonts[ 8 ] )
	set( "theme_override_colors/font_color", ResourceManager.colors[ color ] )
