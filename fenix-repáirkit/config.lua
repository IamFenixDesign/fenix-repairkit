Config = {}

-- Requisitos de trabajo
Config.RequireJob = false -- Cambia a 'true' si deseas que se necesite un trabajo específico para usar el repairkit
Config.AllowedJob = 'mechanic' -- Define el trabajo necesario, si RequireJob es true

-- Selección del minijuego
Config.UseOXLibMinigame = true -- Cambia a 'true' si prefieres usar el minijuego de ox_lib

-- Configuración del minijuego de ps-ui
Config.PsUIMiniGameDifficulty = {
    NumberOfCircles = 2, -- Número de círculos en el minijuego de ps-ui
    TimeLimit = 20 -- Tiempo límite en segundos para ps-ui
}

-- Configuración del minijuego de ox_lib
Config.OXLibSkillCheck = {
    {'easy', 'easy','easy','easy','easy','easy','easy'}, -- Configuración de dificultad para ox_lib
    {'w', 'a', 's', 'd'} -- Teclas para el minijuego de ox_lib
}

-- Animación de reparación
Config.RepairAnimation = 'PROP_HUMAN_BUM_BIN' -- Cambia esta animación si lo deseas

-- Nivel de daño mínimo para permitir la reparación
Config.MinDamageLevel = 900.0 -- Define cuánta salud debe perder el vehículo antes de permitir la reparación

-- Reparar daños visuales
Config.RepairVisualDamage = false -- Si es true, se reparan también los daños visuales

-- Tiempo de reparación en segundos
Config.RepairTime = 25 -- Define cuánto tiempo tarda la reparación (en segundos)
