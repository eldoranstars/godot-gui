extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween
onready var animated_health = 20

func _ready():
		var player_max_health = $"../Characters/Player".max_health
		bar.max_value = player_max_health

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6)
	if not tween.is_active():
		tween.start()

func _on_Player_health_changed(player_health):
	update_health(player_health)

func _process(delta):
		var round_value = round(animated_health)
		number_label.text = str(round_value)
		bar.value = round_value


func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0)
