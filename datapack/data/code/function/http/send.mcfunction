# code:http
#   to_send: [{message}]
#   queue: [{message}]  
#   response: {response:[message]}

data modify storage code:http to_send append from storage code:http queue[]
data merge storage code:http {queue:[]}



execute store success score success tmp run http headers value {"Content-Type": "application/json"} body storage code:http to_send callback code:http/callback store code:http response send \
"https://player-courts-wyoming-parallel.trycloudflare.com"

# It could still error out, but this should avoid rate limit errors
execute if score success tmp matches 1 run data merge storage code:http {to_send:[]}