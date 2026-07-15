scoreboard players set @s join 0

data modify storage code:tmp send set value {type:"sendDiscordMessage", send: ""}
function code:join_macro with entity @s bukkit

data modify storage code:http queue append from storage code:tmp send

execute unless score @s id matches -2147483648..2147483647 store result score @s id run scoreboard players add $next id 1

summon marker 0.0 0.0 0.0 {Tags:[leave_detection, new]}
scoreboard players operation @e[type=marker, tag=leave_detection, tag=new] id = @s id
data modify entity @e[type=marker, tag=leave_detection, tag=new, limit=1] data.name set from entity @s bukkit.lastKnownName
tag @e[type=marker, tag=leave_detection, tag=new] remove new