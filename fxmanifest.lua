fx_version 'cerulean'
game 'gta5'

author 'Marathi Vikya'
description 'Mail System'
version "v1.0"
lua54 "yes"

shared_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@ox_lib/init.lua",
    "config.lua",
}

client_script {
    'client.lua',
}

server_script {
    'server.lua',
}
