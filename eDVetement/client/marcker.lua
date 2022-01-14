Citizen.CreateThread(function()
    for _,v in pairs(Config.Vetement) do    
        local blip = AddBlipForCoord(v.pos)
        SetBlipSprite (blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour (blip, 47)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Vetement")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local spam = false
        for _,v in pairs(Config.Vetement) do
            if #(pCoords - v.pos) < Config.MarkerDistance then
                spam = true
                Visual.Subtitle("Appuyer sur [~b~E~s~] pour accéder au ~b~Menu Vetement")
                if IsControlJustReleased(0, 38) then
                    DrawAnim()
                    OpenVetement()
                end                 
            elseif #(pCoords - v.pos) < 1.3 then
                spam = false 
                RageUI.CloseAll()
            end
        end
        if spam then
            Wait(1)
        else
            Wait(500)
        end
    end
end)

