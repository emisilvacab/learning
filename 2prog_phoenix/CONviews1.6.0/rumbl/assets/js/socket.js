import {Socket} from "phoenix"

let socket = new Socket("/socket", {
    params: {token: window.userToken},
    logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }
})

export default socket

//Conexion simple y basica
//Instancia un nuevo socket en nuestro endpoint
//pasamos parametros y un callback opcional: logger que incluye logs utiles para debuggear en ls consola de js

