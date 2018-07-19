extends Node


# don't forget to reset reference to your node after calling this function
func setFreeing( node ):
	if node:
		node.set_name(node.get_name() + "_freeing")
		node.queue_free()


func greaterThan(a, b):
	return a > b


func getChildrenRecursive(node):
	var nodeReferences = []
	for N in node.get_children():
		nodeReferences.append( N )
		nodeReferences += getChildrenRecursive(N)
	return nodeReferences


func toPaths(nodes):
	var paths = []
	for n in nodes:
		paths.append( n.get_path() )
	return paths


func showAcceptDialog( message, title ):
	var dialog = AcceptDialog.new()
	dialog.set_title( title )
	dialog.set_text( message )
	dialog.set_name( title )
	dialog.popup_exclusive = true
	dialog.connect("confirmed", dialog, "queue_free")
	SceneSwitcher.connect("currentSceneChanged", dialog, "raise")
	get_tree().get_root().add_child(dialog)
	dialog.popup_centered_minsize()
	dialog.show()


func log(message):
	print( message )