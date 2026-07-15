# This could be called less frequently to allow other /http usecases. 
function code:http/send

execute as @a unless score @s join matches 0 run function code:join
execute as @e[type=marker, tag=leave_detection] run function code:leave_marker