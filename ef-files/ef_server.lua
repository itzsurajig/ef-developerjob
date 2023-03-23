local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ef-developer:server:Payslip', function(drops)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney("cash", 490, "developer")
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'EF-PAY $490 To Your Bank Account!'})
end)

RegisterNetEvent('ef-developer:server:Reward', function(drops)
    local chance = math.random(1,100)
    if chance < 25 then
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
        xPlayer.Functions.AddItem("tablet", math.random(0,1), false)
        xPlayer.Functions.AddItem("phone", math.random(0,1), false)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["phone"], "add")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["tablet"], "add")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You found interesting material!'})
    end
            

end)
print("^2cfx.reMonitor ^2EF^7-^2Developer v^41^7.^40 ^7- ^2Script Made By- ^1BlasterSuraj7")




