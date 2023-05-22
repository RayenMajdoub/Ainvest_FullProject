import express from 'express'
import {createServer } from "http"
import { Server } from "socket.io"

//const io = require ('socket.io')(server);

const app = express()
const server = createServer(app)
const port = 4000

const io = new Server(server)
let users = 0 

const validateJWT = (token = "") => {
    try {
        //secret key (jwt)
        const {id: uid} = jwt.verify(token, 'jwt');
        return [true,uid]
    } catch (error) {
        return [true, null];
    }
};

io.on('connection',(socket)=> {
    const [valid, uid] =  validateJWT(socket.handshake.headers['jwt']);
    if (!valid) {
        console.log("hh")
        return socket.disconnect();
    }



    /*to remove */
    let currentId
    if(users == 0){
        currentId = "random1"
        users = users+1;
    }else{
        currentId = "random2"
    }
    /**/
    console.log("Connected Successfully", currentId);
    //current id to id static
    socket.join(currentId)

    socket.on('disconnect', ()=>{
        console.log("Disconnected",socket.id);
    });

    socket.on("private-message", (payload) => {
        //await saveMessage(payload);
        console.log("test: "+payload.message);
        io.to(payload.to).emit("private-message", payload);
    });

    socket.on('message',(data)=>{
        console.log(data);
        data.sentBy = socket.id;
        socket.broadcast.emit('message-receive',data);
    });
});

server.listen(port,()=>{
    console.log("server running")
})
