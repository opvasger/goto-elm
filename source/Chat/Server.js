const { Server, OPEN } = require("ws")

const minLength = 1

const port = 3000

const onListen = () =>
    console.log(`listening at ws://localhost:${port}`)

const onConnection = connection =>
    connection.on("message", onMessage(connection))

const server = new Server({ port })

const onMessage = sender => message =>
    message.length > minLength
    ? server.clients.forEach(client => client.readyState === OPEN && client !== sender && client.send(message))
    : sender.send(`Your message was ${minLength - message.length} characters too short. Please try again.`)

server
    .on("connection", onConnection)
    .on("listening", onListen)