const { Server } = require("ws")

const port = 3000

const onListen = () =>
    console.log(`listening at ws://localhost:${port}`)

const onConnection = connection =>
    connection.on("message", onMessage)

const server = new Server({ port })

const onMessage = message =>
     message.length < 1 || server.clients.forEach(client => client.send(message))

server
    .on("connection", onConnection)
    .on("listening", onListen)