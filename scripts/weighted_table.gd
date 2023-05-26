class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight
	
	
func remove_item(target_item):
	items = items.filter(func(item): 
		if item["item"] == target_item:
			weight_sum -= item["weight"]
			
		return item["item"] != target_item
	)
	
	
func random_item(excluded_items: Array = []):
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum: int = weight_sum
	if excluded_items.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		
		for item in items:
			# using this loop instead of "in" to avoid some errors about finding in a TypedArray
			var found: bool = false
			for excluded_item in excluded_items:
				if item["item"] == excluded_item:
					found = true
					break
			if found:
				continue
			
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
		
	var weight = randi_range(1, adjusted_weight_sum)
	var iter_sum: int = 0
	for item in adjusted_items:
		iter_sum += item["weight"]
		if weight <= iter_sum:
			return item["item"]
			
