extends Spatial

# The amount of damage the weapon will deal
var damage = 10

# The fire rate of the weapon in shots per minute
var fire_rate = 60

# The current ammo count for the weapon
var ammo = 10

# The maximum ammo capacity for the weapon
var ammo_capacity = 10

# A reference to the player character
var player

# A timer to track the time between shots
var shot_timer

func _ready():
	# Set the shot timer to the maximum fire rate
	# to ensure that the weapon can be fired immediately
	shot_timer = fire_rate

func shoot():
	if Input.is_action_just_pressed("fire"):
		fire()
		print("Gun 1 fired")

func fire():
	# Check if the weapon is able to be fired
	if shot_timer >= fire_rate and ammo > 0:
		# Decrement the ammo count
		ammo -= 1
		
		# Reset the shot timer
		shot_timer = 0
		
		# Deal the weapon's damage to the target
	   # target.take_damage(damage)

func _process(delta):
	# Increment the shot timer
	shot_timer += delta * 60
