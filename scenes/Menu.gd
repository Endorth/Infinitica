extends Control



func _on_ConnectButton_pressed():
	TwitchChat.channel = $LineEdit.text
	TwitchChat._anon_connection()



func _on_ExitButton_pressed():
	get_tree().quit()


func _on_TextureButton_toggled(button_pressed):
	OS.window_borderless = button_pressed


func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/Infinitica.tscn")
