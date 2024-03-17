fx_version 'cerulean'
games { 'gta5' }
lua54 = 'yes'
this_is_a_map 'yes'

author 'Offside Development'
description 'OD_Recycling Script QB-Core/QBX-Core'
version '1.0.0'

shared_scripts {
    'shared/config.lua',
--  '@qbx_core/shared/locale.lua', - ENABLE FOR QBX-CORE
    '@qb_core/shared/locale.lua',
    'locales/*.lua',
}

server_scripts {
    'script/server.lua'
}

client_scripts {
    'script/client.lua'
}

dependencies {
--  'qbx_core', - ENABLE FOR QBX-CORE
    'qb_core',
}