extends Node

var music_player : AudioStreamPlayer

func _ready():
	if music_player == null:
		music_player = AudioStreamPlayer.new()
		add_child(music_player)

func play_music(stream : AudioStream):
	if stream == null:
		return
	
	if music_player.stream != stream:
		music_player.stream = stream
		music_player.play()
	elif not music_player.playing:
		music_player.play()

func stop_music():
	music_player.stop()
