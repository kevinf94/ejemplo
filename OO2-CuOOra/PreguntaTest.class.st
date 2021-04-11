Class {
	#name : #PreguntaTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'topicos',
		'topico',
		'usuario1',
		'usuario2',
		'usuario3',
		'respuesta'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
PreguntaTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	topicos := OrderedCollection new.
   topicos add: (Topico conNombre: 'topico1' descripcion: 'descripcion1').
	topicos add: (Topico conNombre: 'topico2' descripcion: 'descripcion2').
	usuario1 := Usuario conNombre: 'user' contrasena: 'pass'.
	pregunta := Pregunta conTopicos: topicos titulo: 'titulo' descripcion: 'descripcion' usuario: usuario1.
	usuario2 := Usuario conNombre: 'juan perez' contrasena: '123'.
	pregunta crearRespuestaConTexto: 'respuesta de juan' usuario: usuario2.
	usuario3 := Usuario conNombre: 'maria garcia' contrasena: 'asd'.
	pregunta crearRespuestaConTexto: 'respuesta de maria' usuario: usuario3.
	topico := (Topico conNombre: 'topico3' descripcion: 'descripcion3').
]

{ #category : #tests }
PreguntaTest >> testCrearRespuestaConTextoUsuario [
	|usuario cantidad|
	usuario := Usuario conNombre: 'otro' contrasena: '123'.
	cantidad := pregunta respuestas size.
	pregunta crearRespuestaConTexto: 'una respuesta' usuario: usuario.
	self assert: pregunta respuestas size equals: cantidad + 1.
	self assert: (pregunta respuestas at: cantidad + 1) texto equals: 'una respuesta'.
	
]

{ #category : #tests }
PreguntaTest >> testEsTuUsuario [
	self assert: (pregunta esTuUsuario: usuario1).
	self deny: (pregunta esTuUsuario: usuario2)
]

{ #category : #tests }
PreguntaTest >> testObtenerRespuestasDelUsuario [
	self assert: (pregunta obtenerRespuestasDelUsuario: usuario1) size equals: 0.
	self assert: (pregunta obtenerRespuestasDelUsuario: usuario2) size equals: 1.
	self assert: (pregunta obtenerRespuestasDelUsuario: usuario3) size equals: 1.
]

{ #category : #tests }
PreguntaTest >> testTieneElTopico [
	self assert: (pregunta tieneElTopico: (topicos at: 1)).
	self deny: (pregunta tieneElTopico: topico).
	
]
