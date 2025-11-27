extends CharacterBody2D

@onready var animacao_player: AnimatedSprite2D = $AnimatedSprite2D
const MAX_JUMP = 2
var jump_count = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum EstadoPlayer{
	parado,
	andando,
	pulando
}
var estado_atual: EstadoPlayer
var direction = 0
func _physics_process(delta: float) -> void:
	# Add the gravity.
	ativar_gravidade(delta)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func ativar_gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
func mover(delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 400 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0 * SPEED, 400 * delta)
	
func atualizar_animacao():
	direction = Input.get_axis("left", "right")
	if direction < 0:
		animacao_player.flip_h = true
	elif direction > 0:
		animacao_player.flip_h = false
	
func preparar_parado():
	estado_atual = EstadoPlayer.parado
	animacao_player.play("parado")

func player_andando(_delta):
	pass

func pode_pular():
	if jump_count < MAX_JUMP:
		return true
	else:
		return false
		
func pular(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if  Input.is_action_just_pressed("jump") && pode_pular():
		return
	if velocity.y > 0:
		return


func parado(delta):
	ativar_gravidade(delta)
	mover (delta)
	if velocity.x != 0 :
		return

	if Input.is_action_just_pressed("jump"):
		preparar_pulo()
		return
	
func preparar_pulo():
	estado_atual = EstadoPlayer.pulando
	animacao_player.play("pulando")
	velocity.y = JUMP_VELOCITY
	jump_count += 1
	
	
func preparar_andando():
	estado_atual = EstadoPlayer.andando
	animacao_player.play("andando")
	
	
