extends KinematicBody2D

export( NodePath ) onready var interact_zone = get_node( interact_zone ) as Area2D
export( NodePath ) onready var interact_labels = get_node( interact_labels ) as Control

export( Resource ) var player_data

var current_interactable

func _ready():
	SignalManager.connect( "item_dropped", self, "_on_item_dropped" )
	player_data.connect( "changed", self, "_on_data_changed" )
	_on_data_changed()

func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion.y /= 2
	motion = motion.normalized() * player_data.get_stat( Game_Enums.STAT.MOVE_SPEED )
	#warning-ignore:return_value_discarded
	move_and_slide(motion)
	if player_data:
		player_data.global_position = global_position

func _process( _delta ):
	if not current_interactable:
		var overlapping_area = interact_zone.get_overlapping_areas()
		
		if overlapping_area.size() > 0 and overlapping_area[ 0 ].has_method( "interact" ):
			current_interactable = overlapping_area[ 0 ]
			interact_labels.display( current_interactable )

func _input( event ):
	if event.is_action_pressed( "interact" ) and current_interactable:
		current_interactable.interact()

func _on_interactable_zone_area_exited( area ):
	if current_interactable == area:
		if current_interactable.has_method( "out_of_range" ):
			current_interactable.out_of_range()
		
		interact_labels.hide()
		current_interactable = null

func _on_item_dropped( item ):
	var floor_item = ResourceManager.tscn.floor_item.instance()
	floor_item.item = item
	get_parent().add_child( floor_item )
	floor_item.position = position

func _on_data_changed():
	global_position = player_data.global_position



