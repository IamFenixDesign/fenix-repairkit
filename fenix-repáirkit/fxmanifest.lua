fx_version 'cerulean'
game 'gta5'

author 'FenixDesign'
description 'Script de reparación de coches con repairkit, compatibilidad con QBCore, qb-inventory, ox-inventory, animaciones y minijuego.'
version '1.0.1'

-- Scripts del cliente
client_scripts {
    'config.lua',
    '@ox_lib/init.lua', -- Cargar ox_lib antes de client.lua
    'client.lua'
}

-- Scripts del servidor
server_scripts {
    'config.lua',
    '@ox_lib/init.lua', -- Cargar ox_lib antes de server.lua
    'server.lua'
}

-- Dependencias requeridas
dependencies {
    'qb-core',
    'ox_lib',
    'ps-ui',
    --'qb-inventory'
    'ox_inventory' -- Puedes cambiar a qb-inventory si usas qb-inventory
}


lua54 'yes'
