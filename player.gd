@export var speed: float = 400.0

func _physics_process(_delta):
	var direction = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var velocity = Vector2(0, direction * speed)
	move_and_slide()





		
@export var speed: float = 400.0
@export var max_health: float = 100.0
@export var health_loss_per_second: float = 1.0
@export var bullet_scene: PackedScene

@onready var muzzle: Marker2D = $Muzzle

var health: float

func _ready() -> void:
	health = max_health

func _physics_process(delta: float) -> void:
	health = maxf(0.0, health - health_loss_per_second * delta)
	if health <= 0.0:
		queue_free()
		return

	var direction := Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(0, direction * speed)
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	if bullet_scene == null:
		push_error("Assign the bullet scene in the Inspector.")
		return

	var bullet := bullet_scene.instantiate() as Area2D
	if bullet == null:
		push_error("The bullet scene root must be an Area2D.")
		return

	bullet.call("set_direction", Vector2.RIGHT)
	bullet.call("set_shooter", self)
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = muzzle.global_position

func heal(amount: float) -> void:
	health = minf(max_health, health + amount)
