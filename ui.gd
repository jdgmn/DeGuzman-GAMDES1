extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	%Message.show()
	$MsgTimer.start()

func show_game_over():
	show_message("It's Over")
	
	await $MsgTimer.timeout
	
	$Message.text = "Message 2 (Test)"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$Button.show()

func update_score(score):
	%Score.text = str(score)

func _on_button_pressed():
	%Button.hide()

func _on_msg_timer_timeout():
	$Message.hide()
