extends Control



func _on_ConnectButton_pressed():
	TwitchChat.channel = $LineEdit.text
	TwitchChat._anon_connection()
	get_tree().change_scene("res://scenes/Infinitica.tscn")
