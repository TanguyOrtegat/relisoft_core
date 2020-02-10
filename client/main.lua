ESX = nil
getEsxInstance(function(obj)
    ESX = obj
end)

local distanceMarkers = getDistanceMarkers()
local markers = getMarkers()
local distanceTexts = getDistanceTexts()
local texts = getTexts()

RegisterNetEvent('rcore:getWeaponAmmoClient')
AddEventHandler('rcore:getWeaponAmmoClient', function(weapon, cb)
    local ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
    cb(ammo)
end)

RegisterNetEvent('rcore:setWeaponAmmo')
AddEventHandler('rcore:setWeaponAmmo', function(weapon, ammo)
    SetPedAmmo(PlayerPedId(), weapon, ammo)
end)

RegisterNetEvent('rcore:addWeaponAmmo')
AddEventHandler('rcore:addWeaponAmmo', function(weapon, ammo)
    AddAmmoToPed(PlayerPedId(), weapon, ammo)
end)

AddEventHandler('updateMarkers', function()
    markers = getMarkers()
    -- Classic marker
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for _, v in pairs(markers) do
                local isAtJobValue = false
                if v.options.jobs ~= nil or not emptyTable(v.options.jobs) then
                    if v.options.grades ~= nil or not emptyTable(v.options.grades) then
                        for _, j in pairs(v.options.jobs) do
                            for _, g in pairs(v.options.grades) do
                                isAtJobValue = isAtJobGrade(j, g)
                                if isAtJobValue then
                                    break
                                end
                            end
                        end
                    else
                        for _, j in pairs(v.options.jobs) do
                            isAtJobValue = isAtJob(j)
                            if isAtJobValue then
                                break
                            end
                        end
                    end
                else
                    isAtJobValue = true
                end

                if isAtJobValue then
                    DrawMarker(v.type,
                        v.coords.x,
                        v.coords.y,
                        v.coords.z,
                        v.options.dir.x,
                        v.options.dir.y,
                        v.options.dir.z,
                        v.options.rot.x,
                        v.options.rot.y,
                        v.options.rot.x,
                        v.options.scale.x,
                        v.options.scale.y,
                        v.options.scale.z,
                        v.options.color.r,
                        v.options.color.g,
                        v.options.color.b,
                        v.options.color.a,
                        v.options.bobUpAndDown,
                        v.options.faceCamera,
                        v.options.p19,
                        v.options.rotate,
                        v.options.textureDict,
                        v.options.textureName,
                        v.options.drawOnEnts)

                    local pos = getPlayerPos()
                    local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z)
                    if dist < v.options.scale.x then
                        if v.options.onEnter ~= nil then
                            v.options.onEnter()
                        end
                    else
                        if v.options.onLeave ~= nil then
                            v.options.onLeave()
                        end
                    end
                end
            end
        end
    end)
end)

-- Distance marker
AddEventHandler('updateDistanceMarkers', function()
    distanceMarkers = getDistanceMarkers()

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for _, v in pairs(distanceMarkers) do
                local isAtJobValue = false
                if v.options.jobs ~= nil or not emptyTable(v.options.jobs) then
                    if v.options.grades ~= nil or not emptyTable(v.options.grades) then
                        for _, j in pairs(v.options.jobs) do
                            for _, g in pairs(v.options.grades) do
                                isAtJobValue = isAtJobGrade(j, g)
                                if isAtJobValue then
                                    break
                                end
                            end
                        end
                    else
                        for _, j in pairs(v.options.jobs) do
                            isAtJobValue = isAtJob(j)
                            if isAtJobValue then
                                break
                            end
                        end
                    end
                else
                    isAtJobValue = true
                end

                if isAtJobValue then
                    local pos = getPlayerPos()
                    local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z)
                    if dist < v.distance then
                        DrawMarker(v.type,
                            v.coords.x,
                            v.coords.y,
                            v.coords.z,
                            v.options.dir.x,
                            v.options.dir.y,
                            v.options.dir.z,
                            v.options.rot.x,
                            v.options.rot.y,
                            v.options.rot.x,
                            v.options.scale.x,
                            v.options.scale.y,
                            v.options.scale.z,
                            v.options.color.r,
                            v.options.color.g,
                            v.options.color.b,
                            v.options.color.a,
                            v.options.bobUpAndDown,
                            v.options.faceCamera,
                            v.options.p19,
                            v.options.rotate,
                            v.options.textureDict,
                            v.options.textureName,
                            v.options.drawOnEnts)
                    end

                    if dist <= v.options.scale.x then
                        if v.options.onEnter ~= nil then
                            v.options.onEnter()
                        end
                    else
                        if v.options.onLeave ~= nil then
                            v.options.onLeave()
                        end
                    end
                end
            end
        end
    end)
end)

-- Distance text
AddEventHandler('updateDistanceTexts', function()
    distanceTexts = getDistanceTexts()

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for _, v in pairs(distanceTexts) do
                local pos = getPlayerPos()
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z)
                if dist < v.distance then
                    draw3DText(v.coords,v.text,v.options)
                end
            end
        end
    end)
end)

-- Text
AddEventHandler('updateTexts', function()
    texts = getTexts()

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for _, v in pairs(texts) do
                draw3DText(v.coords,v.text,v.options)
            end
        end
    end)
end)