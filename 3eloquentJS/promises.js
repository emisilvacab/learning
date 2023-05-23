// https://github.com/kexposito/promises-js-for-explanation/blob/master/promises.js

let miSegundaPromise = new Promise((resolve, reject) => {
  setTimeout(function(){
    console.log("En la segunda promesa");
    resolve("Mensaje Resuelto de la segunda promesa");
  }, 10);
});

let miPrimeraPromise = new Promise((resolve, reject) => {
	setTimeout(function(){
		console.log("En la primera promesa");
		resolve("Mensaje Resuelto de la primera promesa");
	}, 250);
});

const functionAsyncWithAwait = async() => {
	console.log("antes")
	const respuestaUno = await miPrimeraPromise
	const respuestaDos = await miSegundaPromise
	console.log(respuestaUno)
	console.log(respuestaDos)
	console.log("despues")
};

functionAsyncWithAwait();
// antes
//{Debería imprimir primero la de "En la primera promesa" que la de la segunda??}
// En la segunda promesa
// En la primera promesa
// Mensaje resuelto de la primera promesa
// Mensaje resuelto de la segunda promesa
// despues