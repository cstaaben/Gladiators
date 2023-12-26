class_name WeightedTable

const ITEM_KEY = "item"
const WEIGHT_KEY = "weight"

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item, weight: int):
	items.append({ITEM_KEY: item, WEIGHT_KEY: weight})
	weight_sum += weight
	
	
func remove_item(target_item):
	items = items.filter(func(item): 
		if item[ITEM_KEY] == target_item:
			weight_sum -= item[WEIGHT_KEY]
			
		return item[ITEM_KEY] != target_item
	)
	
	
func random_item(excluded_items: Array = []):
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum: int = weight_sum
	if excluded_items.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		
		for item in items:
			if item[ITEM_KEY] in excluded_items:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item[WEIGHT_KEY]
		
	var weight = randi_range(1, adjusted_weight_sum)
	var iter_sum: int = 0
	for item in adjusted_items:
		iter_sum += item[WEIGHT_KEY]
		if weight <= iter_sum:
			return item[ITEM_KEY]
			
