# Http polling experiment

Datapack related to the NodeJS project.

## Make sure to change the URL in code/function/http/send.mcfunction

## How to use
To send a request, just add a new message in the code:http storage in the queue array anytime you want. The tick function will use the /http command itself.

Here are the currently available message types/formats:
- data modify storage code:http queue append value {type:"ping"}
- data modify storage code:http queue append value {type:"getMessage"}
- data modify storage code:http queue append value {type:"setMessage",message:"test"}
- data modify storage code:http queue append value {type:"doMath",expression:"2^31-1"}
- data modify storage code:http queue append value {type:"sendDiscordMessage",content:"<@643945264868098049>"}

(Instructions on how to add more are in the main README)
