Class {
	#name : #PostTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'respuesta',
		'voto',
		'usuario',
		'topicos',
		'usuario1',
		'usuario2'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
PostTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	topicos := OrderedCollection new.
	topicos add: (Topico conNombre: 'topico1' descripcion: 'descripcion1');
		add: (Topico conNombre: 'topico2' descripcion: 'descripcion2').
	usuario1 := (Usuario conNombre: 'user1' contrasena: 'pass1').
	usuario2 := (Usuario conNombre: 'user2' contrasena: 'pass2').
	pregunta := Pregunta conTopicos: topicos titulo: 'titulo' descripcion: 'descripcion' usuario: usuario1.
	respuesta := Respuesta conTexto: 'texto' usuario: usuario2.
]

{ #category : #tests }
PostTest >> testAgregarDislikeDelUsuario [
	self assert: pregunta cantidadDeDislikes equals: 0.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeDislikes equals: 1.
]

{ #category : #tests }
PostTest >> testAgregarLikeDelUsuario [
	self assert: pregunta likes size equals: 0.
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: pregunta likes size equals: 1.
]

{ #category : #tests }
PostTest >> testEsDelUsuario [
	"solo se hace el test con una instancia de pregunta porque una instancia de respuesta lo hereda"
	self assert: (pregunta esDelUsuario: usuario1).
	self deny: (pregunta esDelUsuario: usuario2).
]

{ #category : #tests }
PostTest >> testPuntaje [
	self assert: pregunta puntaje equals: 0.
	pregunta agregarLikeDelUsuario: usuario1.
	pregunta agregarLikeDelUsuario: usuario2.
	self assert: pregunta puntaje equals: 2.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta puntaje equals: 0.
	pregunta quitarDislikeDelUsuario: usuario1.
	self assert: pregunta puntaje equals: 1.
]

{ #category : #tests }
PostTest >> testQuitarDislikeDelUsuario [
	self assert: pregunta puntaje equals: 0.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta puntaje equals: -1.
	pregunta quitarDislikeDelUsuario: usuario1.
	self assert: pregunta puntaje equals: 0.

]

{ #category : #tests }
PostTest >> testQuitarLikeDelUsuario [
	self assert: pregunta puntaje equals: 0.
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: pregunta puntaje equals: 1.
	pregunta quitarLikeDelUsuario: usuario1.
	self assert: pregunta puntaje equals: 0.

]
