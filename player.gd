extends Area2D
signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 0.025
	if Input.is_action_pressed("move_left"):
		velocity.x -= 0.025
	if Input.is_action_pressed("move_up"):
		velocity.y -= 0.025
	if Input.is_action_pressed("move_down"):
		velocity.y += 0.025
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "left"
		if velocity.x > 0:
			$AnimatedSprite2D.animation ="right"		
	if velocity.y != 0:
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "up"
		if velocity.y > 0:
			$AnimatedSprite2D.animation = "down"
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D):
	hide()
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
