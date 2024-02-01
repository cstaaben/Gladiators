extends Node
class_name MapManager


@export var tile_map: TileMap

enum Tile { GROUND }

var _map_size = Vector2(5, 5)
var _walker_count: int = 10
var _walker_loops: int = 100

var _map: Array
var _walkers: Array

func _ready():
	_map = []
	_walkers = []
	for i in _walker_count:
		_walkers.push_back(Walker.new())
		
	for x in _map_size.x:
		for y in _map_size.y:
			tile_map.set_cell(0, Vector2(x, y), 0, Vector2(1, 4))
		
		
func create_map():
	pass
	
	
func stop_walkers():
	pass
	
	
func reset_map():
	pass
	
	
func set_map_size(size: Vector2):
	_map_size = size
	
	
func get_map_size():
	return _map_size
	
	
func set_walker_count(count: int):
	_walker_count = count
	
	
func get_walker_count():
	return _walker_count
	
	
func set_walker_loops(loops: int):
	_walker_loops = loops
	
	
func get_walker_loops():
	return _walker_loops
	
	
func get_walker_birth_chance():
	if _walkers.size() == 0:
		return NAN
		
	return _walkers[0].get_birth_chance()
	
	
func get_walker_death_chance():
	if _walkers.size() == 0:
		return NAN
		
	return _walkers[0].get_death_chance()
	
	
func set_walker_birth_chance():
	pass
	
	
func set_walker_death_chance():
	pass


class Walker:
	extends Node
	
	var _birth_chance: float
	var _death_chance: float
	
	
	func _init(birth_chance: float = 0.05, death_chance: float = 0.01):
		_birth_chance = birth_chance
		_death_chance = death_chance
		
		
	func step():
		pass
		
		
	func should_birth():
		pass
		
		
	func should_die():
		pass
		
		
	func die():
		self.queue_free()
		
		
	func get_birth_chance():
		return _birth_chance
		
		
	func set_birth_chance(v: float):
		_birth_chance = v
		
		
	func get_death_chance():
		return _death_chance
		
		
	func set_death_chance(v: float):
		_death_chance = v
