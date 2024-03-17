local QBCore = exports['qb-core']:GetCoreObject()
local onDuty = false
local searchCooldowns = {}
local tradePedModel = Config.RecycleJob.pedModel
local Translations = Lang

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function CreateTradePed()
    local pedCoords = Config.RecycleJob.pedLocation
    RequestModel(tradePedModel)
    while not HasModelLoaded(tradePedModel) do
        Citizen.Wait(0)
    end
    tradePed = CreatePed(4, tradePedModel, pedCoords.x, pedCoords.y, pedCoords.z, false, true, true)
    SetEntityHeading(tradePed, pedCoords.w) 

    SetEntityAsMissionEntity(tradePed, true, true)
    SetBlockingOfNonTemporaryEvents(tradePed, true)
    SetPedCanBeTargetted(tradePed, false)
    SetPedAsEnemy(tradePed, false)
    FreezeEntityPosition(tradePed, true)
    SetEntityInvincible(tradePed, true)
end

CreateTradePed()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) 
        if not DoesEntityExist(tradePed) then
            CreateTradePed()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)  
        local pedCoords = GetEntityCoords(PlayerPedId())
        local distance = #(pedCoords - vector3(Config.RecycleJob.onDutyLocation.x, Config.RecycleJob.onDutyLocation.y, Config.RecycleJob.onDutyLocation.z))

        local blip = AddBlipForCoord(Config.RecycleJob.onDutyLocation.x, Config.RecycleJob.onDutyLocation.y, Config.RecycleJob.onDutyLocation.z)
    
        SetBlipSprite(blip, 365)  
        SetBlipDisplay(blip, 4)  
        SetBlipScale(blip, 0.6)  
        SetBlipColour(blip, 2)  
        SetBlipAsShortRange(blip, true) 
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Recycling Center")  
        EndTextCommandSetBlipName(blip)

        if distance < 2.5 then
            DrawText3D(Config.RecycleJob.onDutyLocation.x, Config.RecycleJob.onDutyLocation.y, Config.RecycleJob.onDutyLocation.z + 1.0, Lang:t('info.toggle_duty'))
            
            if distance < 1.5 and IsControlJustReleased(0, 38) then  -- E key
                onDuty = not onDuty
                local msg = onDuty and 'success.on_duty' or 'success.off_duty'
                QBCore.Functions.Notify(Lang:t(msg), "success")
            end
        end
    end
end)

for i = 1, #Config.RecycleJob.searchLocations do
    searchCooldowns[i] = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if onDuty then
            for i, searchLoc in pairs(Config.RecycleJob.searchLocations) do
                local distance = #(GetEntityCoords(PlayerPedId()) - searchLoc)
                if distance < 5 then
                    DrawMarker(27, searchLoc.x, searchLoc.y, searchLoc.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, nil, nil, false)
                    if distance < 1.5 then
                        if not searchCooldowns[i] then
                            DrawText3D(searchLoc.x, searchLoc.y, searchLoc.z, Lang:t('info.search'))
                            if IsControlJustReleased(0, 38) then -- E
                                searchCooldowns[i] = true
                                QBCore.Functions.Progressbar("search_recyclables", "Searching...", 8000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "amb@prop_human_bum_bin@base",
                                    anim = "base",
                                    flags = 49,
                                }, {}, {}, function() 
                                    TriggerServerEvent('recycling:giveRecyclableItem') 
                                    ClearPedTasks(PlayerPedId())
                                end, function()
                                    QBCore.Functions.Notify(Lang:t('error.canceled'), "success")
                                    ClearPedTasks(PlayerPedId())
                                    SetTimeout(Config.Reward.searchCooldown * 1000, function()
                                        searchCooldowns[i] = false
                                    end)
                                end, function() 
                                    QBCore.Functions.Notify(Lang:t('error.canceled'), "success")
                                    ClearPedTasks(PlayerPedId())
                                    searchCooldowns[i] = false
                                end)
                            end
                        else
                            DrawText3D(searchLoc.x, searchLoc.y, searchLoc.z, Lang:t('info.searched_already'))
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local distance = #(pedCoords - vector3(Config.RecycleJob.pedLocation.x, Config.RecycleJob.pedLocation.y, Config.RecycleJob.pedLocation.z))

        if distance < 2.5 then
            local pedTextLocation = vector3(Config.RecycleJob.pedLocation.x, Config.RecycleJob.pedLocation.y, Config.RecycleJob.pedLocation.z + 1.0) 
            if onDuty then
                DrawText3D(pedTextLocation.x, pedTextLocation.y, pedTextLocation.z, Lang:t('info.trade_boxes'))
                if IsControlJustReleased(0, 38) then -- E
                    TriggerServerEvent('recycling:exchangeBoxes')
                end
            else
                DrawText3D(pedTextLocation.x, pedTextLocation.y, pedTextLocation.z, Lang:t('info.what_are_you_doing'))
            end
        end
    end
end)

propTable = { 
    "ex_Prop_Crate_Bull_SC_02",
    "ex_prop_crate_wlife_bc",
    "ex_Prop_Crate_watch",
    "ex_Prop_Crate_SHide",
    "ex_Prop_Crate_Oegg",
    "ex_Prop_Crate_MiniG",
    "ex_Prop_Crate_FReel",
    "ex_Prop_Crate_Closed_BC",
    "ex_Prop_Crate_Jewels_BC",
    "ex_Prop_Crate_Art_02_SC",
    "ex_Prop_Crate_clothing_BC",
    "ex_Prop_Crate_biohazard_BC",
    "ex_Prop_Crate_Bull_BC_02",
    "ex_Prop_Crate_Art_BC",
    "ex_Prop_Crate_Money_BC",
    "ex_Prop_Crate_clothing_SC",
    "ex_Prop_Crate_Art_02_BC",
    "ex_Prop_Crate_Money_SC",
    "ex_Prop_Crate_Med_SC",
    "ex_Prop_Crate_Jewels_racks_BC",
    "ex_Prop_Crate_Jewels_SC",
    "ex_Prop_Crate_Med_BC",
    "ex_Prop_Crate_Gems_SC",
    "ex_Prop_Crate_Elec_SC",
    "ex_Prop_Crate_Tob_SC",
    "ex_Prop_Crate_Gems_BC",
    "ex_Prop_Crate_biohazard_SC",
    "ex_Prop_Crate_furJacket_SC",
    "ex_Prop_Crate_Expl_bc",
    "ex_Prop_Crate_Elec_BC",
    "ex_Prop_Crate_Tob_SC",
    "ex_Prop_Crate_Closed_BC",
    "ex_Prop_Crate_Narc_BC",
    "ex_Prop_Crate_Narc_SC",
    "ex_Prop_Crate_Tob_BC",
    "ex_Prop_Crate_furJacket_BC",
    "ex_Prop_Crate_HighEnd_pharma_BC",
    "prop_boxpile_05a",
    "prop_boxpile_04a",
    "prop_boxpile_06b",
    "prop_boxpile_02c",
    "prop_boxpile_02b",
    "prop_boxpile_01a",
    "prop_boxpile_08a",
}

local propSpawnLocations = {
    --Main Props
    vector3(748.01, -1368.06, 11.60),
    vector3(750.44, -1368.08, 11.60),
    vector3(752.81, -1368.07, 11.60),
    vector3(755.25, -1367.98, 11.60),
    vector3(757.68, -1368.05, 11.60),
    vector3(760.04, -1368.12, 11.60),
    vector3(762.48, -1367.97, 11.60),
    vector3(771.20, -1368.09, 11.60),
    vector3(771.23, -1370.57, 11.60),
    vector3(771.24, -1372.94, 11.60),
    vector3(771.32, -1383.10, 11.60),
    vector3(771.31, -1385.54, 11.60),
    vector3(771.136, -1387.91, 11.60),
    vector3(748.03, -1373.44, 11.60),
    vector3(750.42, -1373.42, 11.60),
    vector3(752.90, -1373.42, 11.60),
    vector3(755.28, -1373.42, 11.60),
    vector3(757.66, -1373.43, 11.60),
    vector3(760.08, -1373.40, 11.60),
    vector3(762.49, -1373.47, 11.60),
    vector3(748.02, -1379.29, 11.60),
    vector3(750.451, -1379.24, 11.60),
    vector3(752.83, -1379.26, 11.60),
    vector3(755.21, -1379.29, 11.60),
    vector3(757.65, -1379.25, 11.60),
    vector3(760.07, -1379.27, 11.60),
    vector3(762.54, -1379.20, 11.60),
    vector3(747.98, -1384.97, 11.60),
    vector3(750.42, -1384.87, 11.60),
    vector3(752.81, -1385.01, 11.60),
    vector3(755.25, -1384.99, 11.60),
    vector3(757.65, -1384.96, 11.60),
    vector3(760.05, -1384.80, 11.60),
    vector3(762.55, -1384.95, 11.60),
    vector3(737.57, -1383.00, 11.60),
    vector3(737.55, -1385.40, 11.60),
    vector3(737.56, -1387.86, 11.60),
}

function SpawnWarehouseProps()
    for i, propModelName in ipairs(propTable) do
        local propHash = GetHashKey(propModelName)
        RequestModel(propHash)
        while not HasModelLoaded(propHash) do
            Citizen.Wait(0)
        end

        if propSpawnLocations[i] then
            local x, y, z = table.unpack(propSpawnLocations[i])
            CreateObject(propHash, x, y, z, false, true, true)
        end
    end
end

SpawnWarehouseProps()

local enterLocation = vector3(Config.RecycleJob.enter.x, Config.RecycleJob.enter.y, Config.RecycleJob.enter.z)
local exitLocation = vector3(Config.RecycleJob.outside.x, Config.RecycleJob.exit.y, Config.RecycleJob.exit.z)
local inside = vector3(Config.RecycleJob.inside.x, Config.RecycleJob.inside.y, Config.RecycleJob.inside.z)

function TeleportToWarehouse(isEntering)
    local destination = isEntering and inside or Config.RecycleJob.outside 
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    SetEntityCoords(PlayerPedId(), destination.x, destination.y, destination.z)
    DoScreenFadeIn(800)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distanceToEnter = #(playerCoords - enterLocation)
        local distanceToExit = #(playerCoords - inside) 

        if distanceToEnter < 1.5 then
            DrawText3D(Config.RecycleJob.enter.x, Config.RecycleJob.enter.y, Config.RecycleJob.enter.z, Lang:t('info.enter_warehouse'))
            if IsControlJustReleased(0, 38) then -- E
                TeleportToWarehouse(true)
            end
        elseif distanceToExit < 1.5 then
            DrawText3D(Config.RecycleJob.exit.x, Config.RecycleJob.exit.y, Config.RecycleJob.exit.z, Lang:t('info.exit_warehouse'))
            if IsControlJustReleased(0, 38) then -- E
                TeleportToWarehouse(false)
            end
        end
    end
end)
