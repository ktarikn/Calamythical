extends StaticBody3D


@export var itemNos : Array[int]
@export var items : Array[Node3D]

func acquireItem(item:int):
	items[itemNos.find(item)].visible = true
	
