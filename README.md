# Http polling experiment

This is a simple experiment to test HTTP polling using Node.js and Express. The goal is to have a communication link between this node server and a legitimoose.com instance.

This proof of concept also includes a simple discord chat integration, just for the sake of it.

This project can be seen as a sort of alternative to websockets. This system can therefore be used for almost realtime 2-way communication

## How to use (This was done using Node.js 26 and MC 1.21.10. Other versions may or may not work)
0. set the discord bot token in the src/env.ts file (should contain `export const botToken = "<token>"`)
1. do `npm install` to install dependencies
2. do `npm run dev` to start the dev server
3. run a tunnel of some sort in the background (ie `cloudflared tunnel --url http://localhost:3000`)
4. set the tunnel URL in the `code:http/send` function
5. enjoy

## How to create new message types
MC -> NodeJS: There's not much in mc to do. In Node, add a definition in the IncomingMessage type, and a case in the switch statement in the app.post function.

NodeJS -> MC: Add a type in the OutgoingMessage type. Then, in the code:http/handle_reponse function, add a handler for that type.

## How to send a message
MC -> NodeJS: Add a message to the 'code:http' under the 'queue' array. (ie: `data modify storage code:http queue append value {type:"ping"}`)

NodeJS -> MC: Add an element in the `toSend` array.

## Possible improvements
- Add some sort of auth token in the Node app (cuz rn it will trust whatever reaches it)
- Add some sort of schema validation on the node app (and maybe in mc if not that hard)
- Implement proper error handling and logging
- Implement a better concurrency model (currently, the toSend array is shared between all requests, which can lead to issues)
- Implement some sort of confirmation/request ordering system, as I have the feeling that the order/success of the requests is not guaranteed
- Implement a limit system (as each request cannot go over 10 000 characters.) The current queue system could be adapted quite easily, both on the MC and Node side


Enjoy! 

© PolishKrowa 2026
