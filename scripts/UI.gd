extends Node2D

#INVENTORY
var metal = 0
var wood = 0
var energy = 0
var tech = 0

func _process(_delta):
	$inventory/metal/Label.text = str(metal)
	$inventory/wood/Label.text = str(wood)
	$inventory/energy/Label.text = str(energy)
	$inventory/tech/Label.text = str(tech)
