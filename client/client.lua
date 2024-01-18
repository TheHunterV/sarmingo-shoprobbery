local opljackano = false

CreateThread(function ()
    for k,v in pairs(Config.Shops) do 
    computers(v)
    stash(v)
    end
end)

computers = function (data)
    exports.qtarget:AddBoxZone('shop', vector3(data.computer.coords.x, data.computer.coords.y, data.computer.coords.z - 1), data.computer.lenght, data.computer.width, {
        name='shop',
        heading=data.computer.coords.w,
        debugPoly=false,
        minZ=data.computer.coords.z - 1,
        maxZ=data.computer.coords.x + 2,
        }, {
            options = {
                {
                    action = function ()
                        ESX.TriggerServerCallback('sarmingo-shoprobbery:check', function(moze)
                            if moze then 
                        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 0.5}, 'easy'}, {'w', 'a', 's', 'd'})
                        if success then 
                            local alert = lib.alertDialog({
                                header = 'Code Exposed',
                                content = 'You successfully hack the computer and find the\nfollowing code: ' ..data.computer.code,
                                centered = true,
                                cancel = true
                            })
                            --ADD YOUR DISPATCH FOR POLICE HERE
                            opljackano = true
                        end
                    else
                        ESX.ShowNotification('You dont have device for hacking')
                    end
                    end, data.computer.requireditem)
                    end,
                    icon = data.computer.icon,
                    label = data.computer.label,
                },
            },
            distance = 3.5
    })
end

stash = function (data)
    exports.qtarget:AddBoxZone('stash', vector3(data.stash.coords.x, data.stash.coords.y, data.stash.coords.z - 1), data.stash.lenght, data.stash.width, {
        name='stash',
        heading=data.stash.coords.w,
        debugPoly=false,
        minZ=data.stash.coords.z - 1,
        maxZ=data.stash.coords.x + 2,
        }, {
            options = {
                {
                    action = function ()
                        local input = lib.inputDialog(data.stash.headerdialog, {
                            {type = 'input', label = data.stash.inputlabel, description = data.stash.inputdescription, required = true, placeholder = data.stash.placeholder, icon = data.stash.inputicon},
                          })
                        if not input then return end
                        if input[1] == data.computer.code then
                        lib.progressCircle({
                            duration = 4000,
                            position = 'bottom',
                            label = data.stash.progresstext,
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                                move = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'anim@heists@ornate_bank@grab_cash',
                                clip = 'grab'
                            },
                        })
                        TriggerServerEvent('prodavnica:opljackana', data.stash.reward)
                        opljackano = false
                    end
                    end,
                    icon = data.stash.icon,
                    canInteract = function ()
                        if opljackano then 
                            return true 
                        else
                            return false
                        end
                    end,
                    label = data.stash.label,
                },
            },
            distance = 3.5
    })
end