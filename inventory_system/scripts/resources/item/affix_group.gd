class_name Affix_Group extends Resource

var id : String
var type # Game_Enums.AFFIX_TYPE
var affixes = {}
var apply_to = [] # Game_Enums.EQUIPMENT_TYPE


func _init( affix_grp_id, data ):
	id = affix_grp_id
	type = Game_Enums.AFFIX_TYPE[ data.type ]
	
	for item_type in data.apply_to:
		apply_to.append( Game_Enums.EQUIPMENT_TYPE[ item_type ] )
	
	for affix_id in data.affixes:
		affixes[ affix_id ] = Affix.new( affix_id, data.affixes[ affix_id ] )


func get_random_affix( ilevel ):
	var valid_affixes = []
	
	for a in affixes:
		if ilevel >= affixes[ a ].min_level:
			valid_affixes.append( affixes[ a ] )
	
	valid_affixes.shuffle()
	return valid_affixes[ 0 ].id
