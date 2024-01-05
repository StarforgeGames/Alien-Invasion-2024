class_name Leaderboard
extends Resource


const MAX_NUMBER_ENTRIES = 10
const FILE_PATH = "user://leaderboard.tres"

@export var high_scores: Array[HighScore]


static func load_or_create() -> Leaderboard:
	var leaderboard: Leaderboard

	if not FileAccess.file_exists(FILE_PATH):
		leaderboard = Leaderboard.new()
		leaderboard.save()

	leaderboard = load(FILE_PATH) as Leaderboard
	return leaderboard


func save() -> void:
	sort_descending()

	if high_scores.size() > MAX_NUMBER_ENTRIES:
		high_scores.resize(MAX_NUMBER_ENTRIES)
	
	ResourceSaver.save(self, FILE_PATH)


func add_high_score(new_high_score: HighScore) -> bool:
	if not is_new_high_score(new_high_score.score):
		return false

	high_scores.append(new_high_score)
	sort_descending()

	if high_scores.size() > MAX_NUMBER_ENTRIES:
		high_scores.pop_back()
		
	return true


func is_new_high_score(score: int) -> bool:
	return high_scores.size() < MAX_NUMBER_ENTRIES or high_scores.any(func(hs): return hs.score < score)


func sort_descending() -> void:
	high_scores.sort_custom(func(a, b): return a.score > b.score)
