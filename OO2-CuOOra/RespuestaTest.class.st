Class {
	#name : #RespuestaTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'topic1',
		'pregunta1',
		'respuesta1',
		'respuesta2'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
RespuestaTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	user1 := Usuario conNombre: 'Juan Perez' contrasena: '1234'.
	user2 := Usuario conNombre: 'Alan Kay' contrasena: '12345'.
	user3 := Usuario conNombre: 'Elon Musk' contrasena: '123456'.
	topic1 := Topico
		conNombre: 'Tecnologia'
		descripcion: 'info tecnologia en general'.
	pregunta1 := Pregunta
		conTopicos:
			{topic1.}
		titulo: 'pregunta1'
		descripcion: 'desc1'
		usuario: user1.
	respuesta1 := pregunta1
		crearRespuestaConTexto: 'ans1 for ask1'
		usuario: user3.
	respuesta2 := pregunta1
		crearRespuestaConTexto: 'ans2 for ask1'
		usuario: user1
]

{ #category : #tests }
RespuestaTest >> testBorrate [
	"se verifica que la respuesta se borre de la coleccion de respuestas hechas por un usuario en el sistema "

	| respuesta3 |
	
	self assert: user2 cantidadDeRespuestas equals: 0..
	respuesta3 := pregunta1
		crearRespuestaConTexto: 'ans3 for ask1'
		usuario: user2.
		self assert: user2 cantidadDeRespuestas equals: 1.
		self assert: (user2 respondio: respuesta3 ).
]
