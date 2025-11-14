extends Camera2D

var alvo: Node2D
#
func _ready() -> void:
	buscar_alvo() # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = alvo.position

func buscar_alvo():
	var nodes = get_tree().get_nodes_in_group("Player")
	if nodes.size() == 0:
		push_error("Player não encontrado na cena")
		return

	alvo = nodes [0]
