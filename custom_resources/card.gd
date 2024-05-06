class_name Card
extends Resource

enum Type {ATTACK, DEFEND, BUFF, DEBUFF}
enum Target {SELF, ENEMY}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target

func is_enemy_targeted() -> bool:
	return target == Target.ENEMY
