local QBCore = exports['qb-core']:GetCoreObject()

local spawnedPeds = {}
local ped = PlayerPedId()
local PlayerJob = {}
CompleteRepairs = 0
JobsinSession = {}

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


local function SetJobBlip(title)
    local JobBlip = AddBlipForCoord(Config.Locations[title].coords.x, Config.Locations[title].coords.y, Config.Locations[title].coords.z)
    SetBlipSprite(JobBlip, 521)
    SetBlipDisplay(JobBlip, 4)
    SetBlipScale(JobBlip, 0.7)
    SetBlipAsShortRange(JobBlip, true)
    SetBlipColour(JobBlip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations[title].label)
    EndTextCommandSetBlipName(JobBlip)
end


local function SetWorkBlip(d)
    for k, v in pairs(Config.Locations["jobset" ..d]) do
        WorkBlip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(WorkBlip, 775)
        SetBlipDisplay(WorkBlip, 4)
        SetBlipScale(WorkBlip, 0.6)
        SetBlipAsShortRange(WorkBlip, true)
        SetBlipColour(WorkBlip, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.name)
        EndTextCommandSetBlipName(WorkBlip)
        table.insert(JobsinSession, {id = k, x = v.coords.x, y = v.coords.y, z = v.coords.z, BlipId = WorkBlip})
    end
    TriggerEvent('ef-developerjob:client:Job')
end



local function VehicleCheck(vehicle)
    local retval = false
    for k, v in pairs(Config.JobVehicles) do
        print(v)
        if GetEntityModel(vehicle) == GetHashKey(v) then
            retval = true
        end
    end
    return retval
end



RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('ef-developerjob:client:VehPick', function()
    local choice = math.random(1, #Config.JobVehicles)
    ElecVeh = Config.JobVehicles[choice]
    TriggerEvent('ef-developerjob:client:SpawnVehicle', ElecVeh)
end)


CreateThread(function()
    if Config.ShowBlip then
        SetJobBlip("job")
    end
end)


CreateThread(function()
    local inRange = false
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 10 then
                inRange = true
                DrawMarker(2, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 1.5 then
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Return VAN")

                    end
                    if IsControlJustReleased(0, 38) then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                                if VehicleCheck(GetVehiclePedIsIn(PlayerPedId(), false)) then
                                    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                    for k,v in ipairs(JobsinSession) do
                                        RemoveBlip(v.BlipId)
                                    end
                                else
                                    exports['mythic_notify']:DoHudText('error', 'This is not a van from LifeInvader!')
                                end
                            else
                                exports['mythic_notify']:DoHudText('error', 'You must be the driver of this vehicle!')
                            end
                        end
                    end  
                end
            end
            if not inRange then
                Wait(1000)
            end
    end
end)


RegisterNetEvent('ef-developerjob:client:SpawnVehicle', function(vehicleInfo)
    local coords = Config.Locations["vehicle"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "EF-DEV"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        --exports['LegacyFuel']:SetFuel(veh, 100.0)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(veh)
        StartJob()
    end, coords, true)
end)




function StartJob()
    jobchoice = math.random(1,5)
    SetWorkBlip(jobchoice)
    exports['mythic_notify']:DoHudText('inform', 'Install EF Software at the given Locations in GPS!')
end


RegisterNetEvent('ef-developerjob:client:Job', function(k, v)
    local inRange = false
    CompleteRepairs = 0
    while true do
        Wait(0)
        for k, v in ipairs(JobsinSession) do
            local pos = GetEntityCoords(PlayerPedId())
            if CompleteRepairs < 5 then
                -- if PlayerJob.name == "computer" then
                    if #(pos - vector3(v.x, v.y, v.z)) < 10 then
                        inRange = true
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Fix Software")
                            if IsControlJustReleased(0, 38) then
                                QBCore.Functions.Progressbar("repair_work", "Installing EF Software...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                    anim = "machinic_loop_mechandplayer",
                                    flags = 49,
                                }, {}, {}, function() -- Done
                                    CompleteRepairs = CompleteRepairs + 1
                                    print(CompleteRepairs)
                                    if CompleteRepairs <= 4 then
                                        exports['mythic_notify']:DoHudText('inform', 'Good job </Developer>!')
                                        TriggerServerEvent("ef-developerjob:server:Reward"); 
                                        TriggerServerEvent("ef-developerjob:server:Payslip");
                                    else 
                                        exports['mythic_notify']:DoHudText('inform', 'EF Software Installation Completed')
                                        TriggerServerEvent("ef-developerjob:server:Payslip");
                                    end
                                    RemoveBlip(v.BlipId)
                                    table.remove(JobsinSession, k)
                                end, function() -- Cancel
                                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                                    exports['mythic_notify']:DoHudText('error', 'Denied')
                                end)
                            end  
                        end
 
                    end
                    if not inRange then
                        Wait(1000)
                    end
                -- end
            end
        end
    end
end)

--ped

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k,v in pairs(Config.PedList) do
			local playerCoords = GetEntityCoords(PlayerPedId())
			local distance = #(playerCoords - v.coords.xyz)

			if distance < Config.DistanceSpawn and not spawnedPeds[k] then
				local spawnedPed = NearPed(v.model, v.coords, v.gender, v.animDict, v.animName, v.scenario)
				spawnedPeds[k] = { spawnedPed = spawnedPed }
			end

			if distance >= Config.DistanceSpawn and spawnedPeds[k] then
				if Config.FadeIn then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
					end
				end
				DeletePed(spawnedPeds[k].spawnedPed)
				spawnedPeds[k] = nil
			end
		end
	end
end)

function NearPed(model, coords, gender, animDict, animName, scenario)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(50)
	end

	if Config.MinusOne then
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
	else
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z, coords.w, false, true)
	end

	SetEntityAlpha(spawnedPed, 0, false)

	if Config.Frozen then
		FreezeEntityPosition(spawnedPed, true)
	end

	if Config.Invincible then
		SetEntityInvincible(spawnedPed, true)
	end

	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	end

	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(50)
		end

		TaskPlayAnim(spawnedPed, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

    if scenario then
        TaskStartScenarioInPlace(spawnedPed, scenario, 0, true)
    end

	if Config.FadeIn then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(spawnedPed, i, false)
		end
	end

	return spawnedPed
end

print("^2cfx.reMonitor ^2EF^7-^2Developer v^41^7.^40 ^7- ^2Script Made By- ^1BlasterSuraj^7")
