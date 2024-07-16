local QBCore = exports['qb-core']:GetCoreObject()


function OpenContext(data)
    if QBCore.Functions.HasItem(Config.Required) then
        QBCore.Functions.TriggerCallback('me_mail:server:GetPlayers', function(allplayers)
            local PlayerList = {}
    
            for _, v in pairs(allplayers) do
                if v.sender ~= v.phone then
                    table.insert(PlayerList, {
                        value = v.citizenid,
                        label = v.name .. " (" .. v.phone .. ")"
                    })
                end
            end
    
            local input = lib.inputDialog('MailMenu', {
                {
                    type = 'select',
                    label = 'Receiver',
                    required = true,
                    placeholder = 'Select',
                    options = PlayerList
                },
                {
                    type = "textarea",
                    label = 'Sender',
                    required = true,
                    placeholder = 'Your Name',
                    autosize = true,
                },
                {
                    type = "textarea",
                    label = 'Subject',
                    required = true,
                    placeholder = 'Mail Subject',
                    autosize = true
                },
                {
                    type = "textarea",
                    label = 'Message',
                    required = true,
                    placeholder = 'Type here...',
                    autosize = true
                },
            })
    
            if input then
                data.citizenid = input[1]
                data.sender = input[2]
                data.subject = input[3]
                data.message = input[4]
    
                local mailData = {
                    citizenid = data.citizenid,
                    sender = data.sender,
                    subject = data.subject,
                    message = data.message
                }
                
                TriggerServerEvent("qb-phone:server:sendNewEventMail", data.citizenid, mailData)
                QBCore.Functions.Notify('Mail Send Done!', 'success', 5000)
            end
        end)
    else
        QBCore.Functions.Notify('Phone lele kutte', 'error', 5000)
    end
    
end


RegisterCommand(Config.MailCommand, function(source, args, rawCommand)
    OpenContext({})
end)
