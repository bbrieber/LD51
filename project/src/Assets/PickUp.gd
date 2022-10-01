extends Spatial

export var health_amount : int = 30

func on_pickup(body):
	PlayerData.health += health_amount
	queue_free()
