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
	self assert: user1 cantidadDetopicosDeInteres equals: 0.
	user1 agregarTopicoDeInteres: topico1.
	user1 agregarTopicoDeInteres: topico2.
	self assert: user1 cantidadDetopicosDeInteres equals: 2
	"mejor hacer includes"
]

{ #category : #tests }
UsuarioTest >> testAgregarUsuarioParaSeguir [
self assert: user1 cantidadDeUsuariosSeguidos equals: 0.
	user1 agregarUsuarioParaSeguir: user2.
	user1 agregarUsuarioParaSeguir: user3.
	self assert: user1 cantidadDeUsuariosSeguidos equals: 2
]

{ #category : #tests }
UsuarioTest >> testEsRelevante [
	| preguntaNoRelevante preguntaRelevantePorSeguidor preguntaRelevantePorTopico preguntaRelevantePorTopicoYSegudor |
	user1 agregarTopicoDeInteres: topico1.
	user1 agregarUsuarioParaSeguir: user2.
	preguntaRelevantePorSeguidor := self crearPreguntaRelevante1.
	preguntaRelevantePorTopico := self crearPreguntaRelevante2.
	preguntaRelevantePorTopicoYSegudor := self crearPreguntaRelevante3.
	preguntaNoRelevante := self crearPreguntaNoRelevante.
	
	
	self assert: (user1 esRelevante: preguntaRelevantePorSeguidor).
	self assert: (user1 esRelevante: preguntaRelevantePorTopico).
	self assert: (user1 esRelevante: preguntaRelevantePorTopicoYSegudor).
	self deny: (user1 esRelevante: preguntaNoRelevante)
]
