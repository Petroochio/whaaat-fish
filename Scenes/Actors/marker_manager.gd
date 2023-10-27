extends Node2D

@export var players: Array[Area2D] = []
var screen_size

var server := UDPServer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	server.listen(37373)
	# Set up player spawns
	players[0].set_position(Vector2(screen_size.x * 2 / 3, screen_size.y * 1 / 5))
	players[1].set_position(Vector2(screen_size.x * 2 / 3, screen_size.y * 2 / 5))
	players[2].set_position(Vector2(screen_size.x * 2 / 3, screen_size.y * 3 / 5))
	players[3].set_position(Vector2(screen_size.x * 2 / 3, screen_size.y * 4 / 5))
	players[4].set_position(Vector2(screen_size.x * 1 / 3, screen_size.y * 1 / 5))
	players[5].set_position(Vector2(screen_size.x * 1 / 3, screen_size.y * 2 / 5))
	players[6].set_position(Vector2(screen_size.x * 1 / 3, screen_size.y * 3 / 5))
	players[7].set_position(Vector2(screen_size.x * 1 / 3, screen_size.y * 4 / 5))
	players[0].set_target(Vector2(200, 200))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	server.poll() # Important!
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
#		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
#		print("Received data: %s" % [packet.get_string_from_utf8()])
		# what kind of string "0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7"
		# packet.to_float32_array() # This is the deal
		var msg = packet.get_string_from_utf8().split(" ")
		players[0].set_target(Vector2(float(msg[0]), float(msg[1])))
		print(players[0].target)

func _input(event):
	if event is InputEventMouseButton:
		players[0].set_target(event.position)
