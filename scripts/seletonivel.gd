extends Area2D

@export var nivel_selecionado = ""
var player_spawn:Node2D 
func _on_body_entered(_body: Node2D) -> void:
	call_deferred("selecionar_nivel") # Replace with function body.

func selecionar_nivel():
	get_tree().change_scene_to_file("res://cenas/" +nivel_selecionado+".tscn")
	
	
