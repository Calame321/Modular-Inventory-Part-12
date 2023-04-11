class_name InnerPanel extends PanelContainer

var title : String: set = set_title

# Set the title of the panel.
func set_title( value ):
	title = value
	%title.text = "- " + title + " -"
