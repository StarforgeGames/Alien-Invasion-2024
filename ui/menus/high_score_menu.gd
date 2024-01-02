class_name HighScoreMenu
extends Control


func _ready():
	var leaderboard := load(Leaderboard.FILE_PATH) as Leaderboard
	print(leaderboard.high_scores)
	leaderboard.sort_descending()	
	var high_score_entries = %HighScoreEntries.get_children()
	
	for i in range(high_score_entries.size()):
		var entry = high_score_entries[i]
		var high_score = leaderboard.high_scores[i] if i < leaderboard.high_scores.size() else HighScore.new()

		entry.display(i + 1, high_score)


func _on_back_button_pressed():
	hide()
