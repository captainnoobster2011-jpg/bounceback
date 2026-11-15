extends Sprite2D
@export var enemy_scene: PackedScene
@export_range(1, 20) var min_enemies: int = 2
@export_range(1, 20) var max_enemies: int = 5

func _ready():
	if enemy_scene == null:
		push_error("Assign an enemy scene in the Inspector.")
		return

	if max_enemies < min_enemies:
		push_error("Max Enemies must be greater than or equal to Min Enemies.")
		return

	var bounds := get_viewport().get_visible_rect()
	var enemy_count := randi_range(min_enemies, max_enemies)

	for i in range(enemy_count):
		var enemy := enemy_scene.instantiate() as Node2D
		if enemy == null:
			push_error("The enemy scene's root node must be a Node2D.")
			return

		add_child(enemy)
		enemy.position = Vector2(
			randf_range(bounds.position.x, bounds.end.x),
			randf_range(bounds.position.y, bounds.end.y)
		)
