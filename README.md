# This is mail Command for qb-phone with ox_lib inputDialog

Note : 
Add line in qb-phone/main/server.lua

```qb-phone:server:sendNewEventMail``` in this event

```TriggerClientEvent('qb-phone:client:NewMailNotify', Player.PlayerData.source, mailData)```

Like This

```RegisterNetEvent('qb-phone:server:sendNewEventMail', function(citizenid, mailData)
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if mailData.button == nil then
        MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', { citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0 })
    else
        MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', { citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button) })
    end
    TriggerClientEvent('qb-phone:client:NewMailNotify', Player.PlayerData.source, mailData)
    SetTimeout(200, function()
        local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', { citizenid })
        if mails[1] ~= nil then
            for k, _ in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
        end
        TriggerClientEvent('qb-phone:client:UpdateMails', Player.PlayerData.source, mails)
    end)
end)
```

## Dependancy

- [ox_lib](https://github.com/overextended/ox_lib)

## Screenshots

![image](https://fivemanage.com/_next/image?url=https%3A%2F%2Fr2.fivemanage.com%2FU8OFSecmw26pS1x4rhvgJ%2FScreenshot%202024-07-17%20003958.png&w=640&q=75)

![image](https://fivemanage.com/_next/image?url=https%3A%2F%2Fr2.fivemanage.com%2FU8OFSecmw26pS1x4rhvgJ%2Fmail2.png&w=640&q=75)

