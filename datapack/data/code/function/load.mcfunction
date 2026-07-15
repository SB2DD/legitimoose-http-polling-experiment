gamerule doMobSpawning false
gamerule mobGriefing false
gamerule doFireTick false
gamerule doImmediateRespawn true
gamerule locatorBar false

tellraw @a [{ "color": "#00FF00", "text": "The Code is Load"}, {text:" 67",obfuscated:1b}]

scoreboard objectives add tmp dummy
scoreboard objectives add join custom:leave_game
scoreboard objectives add id dummy