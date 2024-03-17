local QBCore = exports['qb-core']:GetCoreObject()
local Translations = Lang

RegisterServerEvent('recycling:giveRecyclableItem')
AddEventHandler('recycling:giveRecyclableItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amountToGive = math.random(Config.Reward.min, Config.Reward.max)
    
    if Player then
        local itemGiven = Player.Functions.AddItem(Config.Items.recyclableBox, amountToGive)
        if itemGiven then
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.found_boxes', {amount = amountToGive}), "success")
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.failed_add_boxes'), "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.player_not_found'), "error")
    end
end) 

RegisterServerEvent('recycling:exchangeBoxes')
AddEventHandler('recycling:exchangeBoxes', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.player_not_found'), "error")
        return
    end

    local boxCount = Player.Functions.GetItemByName(Config.Items.recyclableBox) and Player.Functions.GetItemByName(Config.Items.recyclableBox).amount or 0

    if boxCount > 0 then
        Player.Functions.RemoveItem(Config.Items.recyclableBox, boxCount)
        for i = 1, boxCount do
            local material = Config.Materials[math.random(1, #Config.Materials)]
            local materialCount = math.random(material.min, material.max)
            Player.Functions.AddItem(material.item, materialCount)
        end
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.traded_boxes', {amount = boxCount}), "success")
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_boxes'), "error")
    end
end)





