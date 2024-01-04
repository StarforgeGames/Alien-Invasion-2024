class_name HighScoreEntry
extends MarginContainer


func _ready() -> void:
	%RankLabel.text = ""
	%NameLabel.text = ""
	%DateTimeLabel.text = ""
	%ScoreLabel.text = ""


func display(rank: int, high_score: HighScore) -> void:	
	%RankLabel.text = str(rank) + "."

	if high_score.name:
		%NameLabel.text = high_score.name
		%DateTimeLabel.text = "{day}-{month}-{year} {hour}:{minute}:{second}".format(high_score.datetime)
		%ScoreLabel.text = str(high_score.score)
