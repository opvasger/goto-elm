const { Server } = require("ws")

const port = 3000

const onListen = () =>
    console.log(`listening at ws://localhost:${port}`)

const onConnection = connection =>
    connection.on("opened", () =>
        connection.send("hello"))

const server = new Server({ port })
    .on("connection", onConnection)
    .on("listening", onListen)