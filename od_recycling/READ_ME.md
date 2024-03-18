IMPORTANT! - QB-Core/QBX-Core Recycable Script Made by Offside Development!

Config.Items = {
    recyclableBox = "recyclable_boxes", 
}
- You will see this within the config this is the recycable item that will give you materials depending on how ever many boxes you have you will receive 1 to 2 material each box you can change the item if you want. 

Config.Materials = {
    { item = "iron", min = 1, max = 2 },
    { item = "copper", min = 1, max = 2 },
    { item = "steel", min = 1, max = 2 },
    { item = "copper_wire", min = 1, max = 2 }
    -- Add more materials if needed
}
- You will be able to set your own mats that you can receive from boxes aswell.

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ITEMS
qb-core/shared/items - 
	['recyclable_boxes'] 					 = {['name'] = 'recyclable_boxes', 					['label'] = 'Recycable Box', 				['weight'] = 450, 		['type'] = 'item', 		['image'] = 'recyclable_boxes.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A box that can be recycled for materials!'},

ox_inventory/data/items -
	["recyclable_boxes"]                     = {
		["name"] = "recyclable_boxes",
		["label"] = "Recycable Box",
		["weight"] = 450,
		["type"] = "item",
		["image"] = "recyclable_boxes.png",
		["unique"] = true,
		["useable"] = false,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "A recycable box!"
	},

    Enjoy the script if there are any bugs report it into our discord!
    Discord - https://discord.gg/8WceG2vTF6
    Preiview - https://www.youtube.com/watch?v=eq7UcmXvlcc
