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
	"Se testea la correcta adición de 'dislike' solo con preguntas y no respuestas, ya que ambas heredan el comportamiento."

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
	"Se testea la correcta adición de 'like' solo con preguntas y no respuestas, ya que ambas heredan el comportamiento."

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
PostTest >> testCantidadDeDislikes [
	"Se testea el correcto funcionamiento del método 'CantidadDeDislikes'. Se verifica que cada pregunta o respuesta registre cantidad de Dislikes. Si un usuario da Dislike no quiere decir que disminuya la cantidad de Likes excepto si él votó Like anteriormente"

	self assert: pregunta cantidadDeDislikes equals: 0.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeDislikes equals: 1.
	pregunta agregarDislikeDelUsuario: usuario2.
	self assert: pregunta cantidadDeDislikes equals: 2.
	pregunta agregarLikeDelUsuario: usuario2.
	self assert: pregunta cantidadDeDislikes equals: 1
]

{ #category : #tests }
PostTest >> testCantidadDeLikes [
	"Se testea el correcto funcionamiento del método 'CantidadDeLikes'. Se verifica que cada pregunta o respuesta registre cantidad de likes. Si un usuario da Like no quiere decir que disminuya la cantidad de dislikes excepto si él votó dislike anteriormente"

	self assert: pregunta cantidadDeLikes equals: 0.
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeLikes equals: 1.
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: pregunta cantidadDeLikes equals: 0.
	pregunta agregarLikeDelUsuario: usuario2.
	self assert: pregunta cantidadDeLikes equals: 1
]

{ #category : #tests }
PostTest >> testEsDelUsuario [
	"Se verifica el correcto funcionamiento del método con preguntas y no con respuestas, ya que ambas heredan el comportamiento."
	self assert: (pregunta esDelUsuario: usuario1).
	self deny: (pregunta esDelUsuario: usuario2).
]

{ #category : #tests }
PostTest >> testPuntaje [
	"Se testea el correcto funcionamiento del método 'Puntaje' solo con preguntas y no
	respuestas, ya que ambas heredan el comportamiento."
	
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
	"Se virifica el correcto funcionamiento del método con preguntas y no respuestas, ya que ambas heredan el comportamiento."

	self deny: (pregunta tieneDislikeDelUsuario: usuario1).
	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: (pregunta tieneDislikeDelUsuario: usuario1).
	pregunta quitarDislikeDelUsuario: usuario1.
	self deny: (pregunta tieneDislikeDelUsuario: usuario1).

]

{ #category : #tests }
PostTest >> testQuitarLikeDelUsuario [
	"Se virifica el correcto funcionamiento del método con preguntas y no respuestas, ya que ambas heredan el comportamiento."
	
	self deny: (pregunta tieneLikeDelUsuario: usuario1).
	pregunta agregarLikeDelUsuario: usuario1.
	self assert: (pregunta tieneLikeDelUsuario: usuario1).
	pregunta quitarLikeDelUsuario: usuario1.
	self deny: (pregunta tieneLikeDelUsuario: usuario1).

]

{ #category : #tests }
PostTest >> testTieneDislikeDelUsuario [
	"Se verifica que pregunta sepa si determinado usuario le dio Dislike y tambien contemple el caso en que el usuario cambie de opinion"

	pregunta agregarDislikeDelUsuario: usuario1.
	self assert: (pregunta tieneDislikeDelUsuario: usuario1).
	pregunta agregarLikeDelUsuario: usuario1.
	self deny: (pregunta tieneDislikeDelUsuario: usuario1).
	self deny: (pregunta tieneLikeDelUsuario: usuario2)
]

{ #category : #tests }
PostTest >> testTieneLikeDelUsuario [
	"Se verifica que una pregunta sepa si determinado usuario le dio Like y tambien contemple el caso en que el usuario cambie de opinion"

	pregunta agregarLikeDelUsuario: usuario1.
	self assert: (pregunta tieneLikeDelUsuario: usuario1).
	pregunta agregarDislikeDelUsuario: usuario1.
	self deny: (pregunta tieneLikeDelUsuario: usuario1).
	self deny: (pregunta tieneLikeDelUsuario: usuario2)
]
