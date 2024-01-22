extends Node


@export var tile_map: TileMap

var noise: FastNoiseLite

func _init():
	noise = FastNoiseLite.new()
