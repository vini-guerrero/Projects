
extends 'BaseType.gd'


func _init():
	_name = 'Int'
	_t = TYPE_INT


func getVal():  # int
	if _rematch and _rematch is RegExMatch:
		return int(_rematch.get_string())

	return 0
