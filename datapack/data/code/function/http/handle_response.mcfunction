data modify storage code:http_tmp response_msg set from storage code:http response.response[0]
data remove storage code:http response.response[0]

execute if data storage code:http_tmp {response_msg:{type:"pong"}} run tellraw @a [{"text":"[Fake Server] pong recieved"}]
execute if data storage code:http_tmp {response_msg:{type:"started"}} run tellraw @a [{"text":"[Fake Server] remote server started"}]
execute if data storage code:http_tmp {response_msg:{type:"messageData"}} run tellraw @a [{"text":"[Fake Server] got message "},{storage:"code:http_tmp",nbt:"response_msg.value"}]
execute if data storage code:http_tmp {response_msg:{type:"mathResponse"}} run tellraw @a [{"text":"[Fake Server] got math "},{storage:"code:http_tmp",nbt:"response_msg.value"}]
execute if data storage code:http_tmp {response_msg:{type:"discordMessage"}} unless data storage code:http_tmp {response_msg.from:"http-testing"} run tellraw @a [{text:"[Discord] ",color:"blue"},{storage:"code:http_tmp",nbt:"response_msg.from",interpret:true,color:"white"},{text:": "},{storage:"code:http_tmp",nbt:"response_msg.content",interpret:true,color:"white"}]

execute if data storage code:http response.response[0] run function code:http/handle_response