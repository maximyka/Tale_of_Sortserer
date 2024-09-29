extends Node

var config
var path_to_save_file := 'user://Tale_of_sortserer.cfg'
var section_name = 'game'

var after = 'start'
var count_talk: int = 1
var count_talk_museum: int = 1
var stones: int = 0

var win: bool = false

func _ready() -> void:
	load_game()

func save_game():
	config.set_value(section_name, 'count_talk', count_talk)
	config.set_value(section_name, 'count_talk_museum', count_talk_museum)
	config.set_value(section_name, 'stones', stones)

func load_game():
	config = ConfigFile.new()
	config.load(path_to_save_file)
	count_talk = config.get_value(section_name, 'count_talk', 1)
	count_talk_museum = config.get_value(section_name, 'count_talk_museum', 1)
	stones = config.get_value(section_name, 'stones', 0)
