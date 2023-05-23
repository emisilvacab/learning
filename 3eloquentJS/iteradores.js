function iteradorBasico(array){
    var siguienteIndice = 0;

    return {
        next: function(){
            return siguienteIndice < array.length ?
                {value: array[siguienteIndice++], done: false}:
                {done: true};
        }
    }
}

//Una vez inicializado, se puede invocar al método next() para acceder a las parejas llave-valor del objeto en cuestión:

var it = iteradorBasico(['yo', 'ya']);
console.log("Iterador basico--------------------------");
console.log(it.next()); // {value: 'yo', done: false}
console.log(it.next().value); // ya
console.log(it.next().done);  // true

// Lo mismo pero con generador

function* iteradorBasicoConGenerador(array){
    var siguienteIndice = 0;
    while (siguienteIndice < array.length)
        yield array[siguienteIndice++]
}

var itp = iteradorBasicoConGenerador(['yo', 'ya']);
console.log("Iterador basico con generador------------");
console.log(itp.next()); // {value: 'yo', done: false}
console.log(itp.next().value); // ya
console.log(itp.next().done);  // true


//Generador de ids

function* hacedorIds() {
    var indice = 0;
    while(true)
        yield indice++;
}

var generador = hacedorIds();
console.log("Generador de ids-------------------------")
console.log(generador.next().value); // 0
console.log(generador.next().value); // 1
console.log(generador.next().value); // 2
console.log(generador.next().done);// false
console.log(generador.next().value); // 4
console.log(generador.value); // undefined


