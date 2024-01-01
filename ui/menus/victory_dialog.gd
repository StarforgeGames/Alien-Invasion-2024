extends ColorRect


@onready var high_score_container := $MarginContainer/VBoxContainer/HighscoreContainer as VBoxContainer


func _ready() -> void:
	%NameLineEdit.text = ""
	high_score_container.modulate = Color(1, 1, 1, 0)
	if Game.leaderboard.is_new_high_score(Game.score):
		var tween = create_tween().tween_property(high_score_container, "modulate", Color(1, 1, 1, 1), 1.0)
		tween.set_ease(Tween.EASE_IN)


func _on_continue_button_pressed() -> void:
	_save_highscore()
	hide()
	Ui.load_main_menu()


func _on_play_again_button_pressed() -> void:
	_save_highscore()
	hide()
	Game.restart()


func _save_highscore() -> void:
	if not Game.leaderboard.is_new_high_score(Game.score):
		return

	var high_score = HighScore.new()
	high_score.name = %NameLineEdit.text
	high_score.score = Game.score + Game._current_player_lifes
	high_score.datetime = Time.get_datetime_dict_from_system()

	Game.leaderboard.add_high_score(high_score)
	Game.leaderboard.save()
