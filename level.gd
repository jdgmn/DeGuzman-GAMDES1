extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over():
	$ScoreTime.stop()
	$SpawnTime.stop()

func new_game():
	score = 0
	$Player.start($StartPos.position)
	$StartTime.start()
	get_tree().call_group("enems", "queue_free")

func _on_spawn_time_timeout():
	var enem = mob_scene.instantiate()
	
	var enem_spawn_loc = $EnemPath/EnemSpawnLoc
	enem_spawn_loc.progress_ratio = randf()
	
	enem.position = enem_spawn_loc.position
	
	var direction = enem_spawn_loc.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	enem.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enem.linear_velocity = velocity.rotated(direction)
	
	add_child(enem)


func _on_score_time_timeout():
	score += 1


func _on_start_time_timeout():
	$SpawnTime.start()
	$ScoreTime.start()
