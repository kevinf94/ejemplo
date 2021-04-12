Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'topico1',
		'topico2',
		'topico3'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #internal }
UsuarioTest >> crearPreguntaNoRelevante [
	"Retorna una pregunta que no es relevante para el usuario."
	^ Pregunta
		conTopicos:
			{topico2.
			topico3}
		titulo: 'pregunta 4 ?'
		descripcion: 'pregunta no relevante, no posee topico de interes usuario ni sigue a su autor'
		usuario: user3
]

{ #category : #internal }
UsuarioTest >> crearPreguntaRelevante1 [
	"Retorna una pregunta que es relevante para un usuario determinado, porque ésta fue creada por otro usuario que
	se encuentra en la colección de 'usuarios seguidos' del primer usuario mencionado."
	^ Pregunta
		conTopicos:
			{topico2.
			topico3}
		titulo: 'Pregunta 1 ?'
		descripcion: 'pregunta relevante porque fue hecha por usuario seguido'
		usuario: user2
]

{ #category : #internal }
UsuarioTest >> crearPreguntaRelevante2 [
	"Retorna una pregunta que es de relevancia para un usuario determinado porque ésta poseé un tópico que es de
	interés para dicho usuario."
	^ Pregunta
		conTopicos:
			{topico1.
			topico3}
		titulo: 'pregunta 2 ?'
		descripcion: 'pregunta relevante por tener topico de interes para el usuario'
		usuario: user3
]

{ #category : #internal }
UsuarioTest >> crearPreguntaRelevante3 [
	"Retorna una pregunta que es relevante para un usuario determinado porque ésta fue creada con un tópico que es de
	interés para dicho usuario, y porque la pregunta fue creadad por otro usuario, el cual es seguido por el primer
	usuario mencionado."
	^ Pregunta
		conTopicos:
			{topico1.
			topico2.
			topico3}
		titulo: 'pregunta 3 ?'
		descripcion:
			'pregunta relevante por ser topico de interes para el usuario y ser hecha por un seguido'
		usuario: user3
]

{ #category : #running }
UsuarioTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	user1 := Usuario conNombre: 'Juan Perez' contrasena: '1234'.
	user2 := Usuario conNombre: 'Alan Kay' contrasena: '12345'.
	user3 := Usuario conNombre: 'Elon Musk' contrasena: '123456'.
	topico1 := Topico conNombre: 'Tecnologia' descripcion: 'info tecnologia en general'.
	
   topico2 := Topico
		conNombre: 'Deportes'
		descripcion: 'acerca de deportes'.
	topico3 := Topico
		conNombre: 'Peliculas'
		descripcion: 'acerca de peliculas'
]

{ #category : #tests }
UsuarioTest >> testAgregarTopicoDeInteres [
	"se verifica la correcta adición de tópicos de interés para el usuario."
	
	self assert: user1 cantidadDetopicosDeInteres equals: 0.
	user1 agregarTopicoDeInteres: topico1.
	user1 agregarTopicoDeInteres: topico2.
	self assert: user1 cantidadDetopicosDeInteres equals: 2.

	self assert: (user1 esTopicoDeInteres: topico1).
	self assert: (user1 esTopicoDeInteres: topico2).
	self deny: (user1 esTopicoDeInteres: topico3).
]

{ #category : #tests }
UsuarioTest >> testAgregarUsuarioParaSeguir [

	"Se verifica la correcta adición de usuarios para seguir, para un determinado usuario."

	self assert: user1 cantidadDeUsuariosSeguidos equals: 0.
	user1 agregarUsuarioParaSeguir: user2.
	user1 agregarUsuarioParaSeguir: user3.
	self assert: user1 cantidadDeUsuariosSeguidos equals: 2.
	
	self deny: (user1 esUsuarioSeguido: user1).
	self assert: (user1 esUsuarioSeguido: user2).
	self assert: (user1 esUsuarioSeguido: user3).
]

{ #category : #tests }
UsuarioTest >> testEsRelevante [
	"Se verficia el correcto funcionamiento para detectar preguntas relevantes para un usuario determinado."

	| preguntaNoRelevante preguntaRelevantePorSeguidor preguntaRelevantePorTopico preguntaRelevantePorTopicoYSeguidor |
	user1 agregarTopicoDeInteres: topico1.
	user1 agregarUsuarioParaSeguir: user2.
	preguntaRelevantePorSeguidor := self crearPreguntaRelevante1.
	preguntaRelevantePorTopico := self crearPreguntaRelevante2.
	preguntaRelevantePorTopicoYSeguidor := self crearPreguntaRelevante3.
	preguntaNoRelevante := self crearPreguntaNoRelevante.
	
	
	self assert: (user1 esRelevante: preguntaRelevantePorSeguidor).
	self assert: (user1 esRelevante: preguntaRelevantePorTopico).
	self assert: (user1 esRelevante: preguntaRelevantePorTopicoYSeguidor).
	self deny: (user1 esRelevante: preguntaNoRelevante)
]
