Config = {}

Config.RecycleJob = {
    onDutyLocation = vector3(738.98, -1376.51, 11.64),
    searchLocations = {
        vector3(750.36, -1377.96, 12.63),
        vector3(748.03, -1374.89, 12.63),
        vector3(752.94, -1374.85, 12.63),
        vector3(755.16, -1377.95, 12.63),
        vector3(757.69, -1374.81, 12.63),
        vector3(760.09, -1377.76, 12.63),
        vector3(762.50, -1374.89, 12.63),
        vector3(762.61, -1380.32, 12.63),
        vector3(759.98, -1383.50, 12.63),
        vector3(757.69, -1380.54, 12.63),
        vector3(755.25, -1383.81, 12.63),
        vector3(752.89, -1380.38, 12.63),
        vector3(750.31, -1383.57, 12.63),
        vector3(748.03, -1380.55, 12.63),
        vector3(738.84, -1385.34, 12.63),
        vector3(750.41, -1386.26, 12.63),
        vector3(755.28, -1386.21, 12.63),
        vector3(760.04, -1386.13, 12.63),
        vector3(769.91, -1385.55, 12.63),
        vector3(769.71, -1370.75, 12.63),
        vector3(762.49, -1369.38, 12.63),
        vector3(760.07, -1371.89, 12.63),
        vector3(757.68, -1369.38, 12.63),
        vector3(755.18, -1371.97, 12.63),
        vector3(752.87, -1369.53, 12.63),
        vector3(750.39, -1371.96, 12.63),
        vector3(748.05, -1369.31, 12.63),
    },
    enter = vector3(746.87, -1399.34, 26.62),
    exit = vector3(736.76, -1374.40, 12.64),
    inside = vector3(736.70, -1374.39, 12.64),
    outside = vector3(746.87, -1399.34, 26.62),
    pedLocation = vector4(741.72, -1376.10, 11.63, 271.00), 
    pedModel = "a_m_m_business_01"
}

Config.Items = {
    recyclableBox = "recyclable_boxes", 
}

Config.Reward = {
    min = 1,
    max = 3,
    searchCooldown = 120, 
}

Config.Materials = {
    { item = "iron", min = 1, max = 2 },
    { item = "copper", min = 1, max = 2 },
    { item = "steel", min = 1, max = 2 },
    { item = "copper_wire", min = 1, max = 2 }
    -- Add more materials if needed
}

