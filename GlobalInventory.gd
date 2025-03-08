extends Node




var inventory :Array[int] 

func acquire(item : int):
	inventory.append(item)

func useItem(item:int):
	inventory.erase(item)
	
