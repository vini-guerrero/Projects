extends Node


signal sendVariable(name, value)


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
