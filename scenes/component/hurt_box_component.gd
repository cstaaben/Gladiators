extends Area2D
class_name HurtboxComponent


@export var health: HealthComponent


func _ready():
    area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D):
    if not area is HitboxComponent or health == null:
        return

    var hitbox = area as HitboxComponent
    health.damage(hitbox.damage)
