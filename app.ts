import express, {Request, Response} from 'express';
import {all, create} from "mathjs";
import {Client, Events, GatewayIntentBits, SendableChannels} from "discord.js";
import {botToken} from "./src/env";

const app = express()

const client = new Client({intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent]});

async function start() {

    // Discord bot
    client.once(Events.ClientReady, (readyClient) => {
        console.log(`Ready! Logged in as ${readyClient.user.tag}`);
    });

    client.login(botToken);
    client.on(Events.MessageCreate, (message) => {

        console.log(`Discord Message received: ${message.content}`);


        toSend.push({type: "discordMessage", content: message.content, from: message.author.displayName})
    });


    // web server
    app.listen(3000, () => {
        console.log(`Controller listening on port ${3000}`)

        toSend.push({type: "started"})
    })
}

app.use(express.json());

app.get('/', (req: Request, res: Response) => {
    res.send("ae")
})


type IncomingMessage = {type: "ping"}
    | {type: "setMessage", message: string}
    | {type: "getMessage"}
    | {type: "doMath", expression: string}
    | {type: "sendDiscordMessage", content: string}

type OutgoingMessage = {type: "started"}
    | {type: "pong"}
    | {type: "messageData", value: string}
    | {type: "mathResponse", value: string}
    | {type: "discordMessage", content: string, from: string}


let toSend: OutgoingMessage[] = []

let storedMessage = "none"
const math = create(all)

app.post('/', function (req, res, next) {
    // Possible TODOs:
    // - Add authentication for the controller
    // - Better concurrency support (with toSend, there's prob issues with that)

    const messages = req.body as IncomingMessage[]

    if (messages.length !== 0)
        console.log(`Received: ${JSON.stringify(messages)}`)

    for (const message of messages) {
        switch (message.type) {
            case "ping": {
                toSend.push({type: "pong"})
                break;
            }
            case "setMessage": {
                storedMessage = message.message
                toSend.push({type: "messageData", value: storedMessage})
                break;
            }
            case "getMessage": {
                toSend.push({type: "messageData", value: storedMessage})
                break;
            }
            case "doMath": {
                const response = math.evaluate(message.expression)

                toSend.push({type: "mathResponse", value: response})
                break;
            }
            case "sendDiscordMessage": {
                let msg = message.content as string

                msg = msg.replace("@everyone", "no")

                if (client.isReady()) {
                    (client.channels.cache.get("1527006788761817161") as SendableChannels)?.send(msg);
                }

                break;
            }
        }

    }

    let responses = toSend

    if (responses.length !== 0)
        console.log(`Sending: ${JSON.stringify(responses)}`)

    res.json(responses)
    toSend = []
});


start()