extends VBoxContainer

const UtilityGd              = preload("res://Utility.gd")

const UnitCreatorName = "UnitCreator"

var m_mainMenu


func _ready():
	m_mainMenu = get_parent()
	m_mainMenu.get_node("Buttons/NewGame").connect("pressed", self, "deleteCreator")
	m_mainMenu.get_node("Buttons/JoinGame").connect("pressed", self, "deleteCreator")
	
	
func newCreator():
	var unitCreator = UnitCreator.new()
	unitCreator.name = UnitCreatorName
	Connector.connect("newGameSceneConnected", unitCreator, "connectOnReady" )
	
	deleteCreator()
	get_tree().get_root().add_child( unitCreator )
	
	
func deleteCreator():
	if not get_tree().get_root().has_node(UnitCreatorName):
		return

	var creator = get_tree().get_root().get_node(UnitCreatorName)
	UtilityGd.setFreeing( creator )


func _on_JoinCreateButton_pressed():
	newCreator()
	m_mainMenu.joinGame()


func _on_NewCreateButton_pressed():
	newCreator()
	m_mainMenu.newGame()




class UnitCreator extends Node:
	func connectOnReady( newGameScene ):
		newGameScene.connect( "ready", self, "createUnit", [newGameScene] )


	func createUnit( newGameScene ):
		if is_queued_for_deletion():
			return

		var units = newGameScene.m_module.getUnitsForCreation()
		assert( units.size() > 0 )

		var creationData = {
			"path" : units[0],
			"owner" : 0 if not get_tree().has_network_peer() else get_tree().get_network_unique_id()
		}

		newGameScene.get_node( "Lobby" ).createCharacter( creationData )
		self.queue_free()