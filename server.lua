local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('me_mail:server:GetPlayers', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    local allplayers = {}
    local players = MySQL.Sync.fetchAll('SELECT citizenid, charinfo FROM players')
    if players[1] ~= nil then
        for _, value in pairs(players) do
            local charinfo = json.decode(value.charinfo)
            local phone = charinfo.phone
            local firstname = charinfo.firstname
            local lastname = charinfo.lastname
            local citizenid = value.citizenid


            local Target = QBCore.Functions.GetPlayerByPhone(phone)
            
            if Target then
                allplayers[#allplayers + 1] = {
                    citizenid = value.citizenid,
                    sender = Player.PlayerData.charinfo.phone,
                    phone = phone,
                    name = '🟢 ' .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname
                }
            end
        end
    end
    cb(allplayers)
end)
