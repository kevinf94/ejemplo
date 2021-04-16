Class {
	#name : #PreguntaTest,
	#superclass : #TestCase,
	#instVars : [
		'usuario1',
		'usuario2',
		'usuario3',
		'topico1',
		'topico2',
		'topico3',
		'pregunta1',
		'respuesta1',
		'respuesta2'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
PreguntaTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
   topico1 := Topico conNombre: 'topico1' descripcion: 'descripcion1'.
	topico2 := Topico conNombre: 'topico2' descripcion: 'descripcion2'.
	
	usuario1 := Usuario conNombre: 'user' contrasena: 'pass'.
	pregunta1 := Pregunta conTopicos: { topico1. topico2. } titulo: 'titulo' descripcion: 'descripcion' usuario: usuario1.
	
	usuario2 := Usuario conNombre: 'juan perez' contrasena: '123'.
	respuesta1 := pregunta1 crearRespuestaConTexto: 'respuesta de juan' usuario: usuario2.
	
	usuario3 := Usuario conNombre: 'maria garcia' contrasena: 'asd'.
	respuesta2 := pregunta1 crearRespuestaConTexto: 'respuesta de maria' usuario: usuario3.
	
	topico3 := Topico conNombre: 'topico3' descripcion: 'descripcion3'.
]

{ #category : #tests }
PreguntaTest >> testCantidadDeRespuestas [
	"Se verifica el correcto funcionamiento del método <<cantidadDeRespuestas. "

	self assert: pregunta1 cantidadDeRespuestas equals: 2.
	pregunta1
		crearRespuestaConTexto: 'otra respuesta del usuario 2'
		usuario: usuario2.
	self assert: pregunta1 cantidadDeRespuestas equals: 3.
]

{ #category : #tests }
PreguntaTest >> testCrearRespuestaConTextoUsuario [
	
	"Se verifica la correcta creación de una respuesta."
	
	|usuario respuesta|
	
	usuario := Usuario conNombre: 'otro' contrasena: '123'.
	respuesta := pregunta1 crearRespuestaConTexto: 'una respuesta' usuario: usuario.
	self assert: (pregunta1 tenesLaRespuesta: respuesta).
	self assert: (usuario respuestas includes: respuesta).
	
]

{ #category : #tests }
PreguntaTest >> testEsTuUsuario [
	"Se verifica el correcto funcionamiento del método."
	
	self assert: (pregunta1 esTuUsuario: usuario1).
	self deny: (pregunta1 esTuUsuario: usuario2)
]

{ #category : #tests }
PreguntaTest >> testRespuestas [
	"Se verifica el correcto funcionamiento del método respuestas. Si agrego mas likes a 'respuesta1', la coleccion ordenada que devuelve el metodo <<respuestas la posicionará primero "

	| respuestasEnOrdenPorPuntaje |
	respuesta1 agregarLikeDelUsuario: usuario1.
	respuesta1 agregarLikeDelUsuario: usuario2.
	respuesta2 agregarLikeDelUsuario: usuario1.
	respuestasEnOrdenPorPuntaje := pregunta1 respuestas.
	self assert: respuestasEnOrdenPorPuntaje first equals: respuesta1.
	self assert: respuestasEnOrdenPorPuntaje second equals: respuesta2
]

{ #category : #tests }
PreguntaTest >> testTieneElTopico [

	"Se verifica el correcto funcionamiento del método."

	|topico|
	topico := Topico conNombre: 'Test' descripcion: 'testeando'.
	self assert: (pregunta1 tieneElTopico: topico1).
	self deny: (pregunta1 tieneElTopico: topico).
	
]
