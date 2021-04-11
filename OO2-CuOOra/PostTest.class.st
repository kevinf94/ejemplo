Class {
	#name : #PostTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'respuesta',
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
	"Se testea Dislike solo con preguntas y no respuestas, ya que ambas heredan el comportamiento."

	|voto|
	self assert: pregunta cantidadDeDislikes equals: 0.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeDislikes equals: 1.
	voto := pregunta votos detect: [ :v | v esDelUsuario: usuario1 ].
	self assert: voto esDislike.
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeDislikes equals: 0.
	self assert: (pregunta votos includes: voto).
	self deny: voto esDislike.
]

{ #category : #tests }
PostTest >> testAgregarLikeDelUsuario [
	"Se testea Dislike solo con preguntas y no respuestas, ya que ambas heredan el comportamiento."

	|voto|
	self assert: pregunta cantidadDeLikes equals: 0.
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeLikes equals: 1.
	voto := pregunta votos detect: [ :v | v esDelUsuario: usuario1 ].
	self assert: voto esLike.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeLikes equals: 0.
	self assert: (pregunta votos includes: voto).
	self deny: voto esLike.
]

{ #category : #tests }
PostTest >> testEsDelUsuario [
	"Se testea Dislike solo con preguntas y no respuestas, ya que ambas heredan el atributo."
	self assert: (pregunta esDelUsuario: usuario1).
	self deny: (pregunta esDelUsuario: usuario2).
]

{ #category : #tests }
PostTest >> testPuntaje [
	"Se testea Puntaje solo con preguntas y no respuestas, ya que ambas heredan el comportamiento."
	
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

	self deny: (pregunta tieneDislikeDelUsuario: usuario1).
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: (pregunta tieneDislikeDelUsuario: usuario1).
	pregunta quitarDislikeDelUsuario: usuario1.
	self deny: (pregunta tieneDislikeDelUsuario: usuario1).

]

{ #category : #tests }
PostTest >> testQuitarLikeDelUsuario [

	self deny: (pregunta tieneLikeDelUsuario: usuario1).
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: (pregunta tieneLikeDelUsuario: usuario1).
	pregunta quitarLikeDelUsuario: usuario1.
	self deny: (pregunta tieneLikeDelUsuario: usuario1).

]
