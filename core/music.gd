extends Node

var music_player = AudioStreamPlayer.new()

var in_menu = true

var menumusic = preload("res://music/GMTK2020_drums.ogg")
var gamemusic = preload("res://music/GMTK2020_full.ogg")

func _ready():
	music_player.volume_db = -5
	music_player.stream = menumusic
	music_player.play()
	add_child(music_player)

func change_music():
	var playingpos = 0.0
	music_player.stop()
	
	#If it's in menu, select the other music
	#and start playing it
	if in_menu:
		#Here, continue where we left it
		playingpos = music_player.get_playback_position()
		music_player.stream = gamemusic
	else:
		#From the beginning
		music_player.stream = menumusic
	
	in_menu = not in_menu
	music_player.play(playingpos)
