scoreboard players operation $id id = @s id
execute as @a if score @s id = $id id run return 0


data modify storage code:tmp send set value {type:"sendDiscordMessage", send: ""}
function code:leave_macro with entity @s data

data modify storage code:http queue append from storage code:tmp send

kill @s