Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'topic1',
		'topic2',
		'topic3',
		'ask1',
		'ask2',
		'ask3',
		'ans1',
		'ans2',
		'ans3'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #internal }
UsuarioTest >> crearPreguntaNoRelevante [
	"Retorna una pregunta que no es relevante para el usuario."
	^ Pregunta
		conTopicos:
			{topic2.
			topic3}
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
			{topic2.
			topic3}
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
			{topic1.
			topic3}
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
			{topic1.
			topic2.
			topic3}
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

	topic1 := Topico conNombre: 'Tecnologia' descripcion: 'info tecnologia en general'.
   topic2 := Topico conNombre: 'Deportes' descripcion: 'acerca de deportes'.
	topic3 := Topico conNombre: 'Peliculas' descripcion: 'acerca de peliculas'.

	ask1 := Pregunta conTopicos: { topic1. topic2. } titulo: 'pregunta1' descripcion: 'desc1' usuario: user1.
	ask1 agregarLikeDelUsuario: user3.
	
	ask2 := Pregunta conTopicos: { topic1. topic3. } titulo: 'pregunta2' descripcion: 'desc2' usuario: user2.
	ask2 agregarDislikeDelUsuario: user3.
	
	ask3 := Pregunta conTopicos: { topic3. } titulo: 'pregunta3'  descripcion: 'desc3' usuario: user3.
	
	ans1 := ask1 crearRespuestaConTexto: 'ans1 for ask1' usuario: user3.
	ans1 agregarLikeDelUsuario: user1.
	
	ans2 := ask1 crearRespuestaConTexto: 'ans2 for ask2' usuario: user1.
	ans2 agregarLikeDelUsuario: user2.
	
	ans3 := ask2 crearRespuestaConTexto: 'ans1 for ask2' usuario: user3.
	ans3 agregarLikeDelUsuario: user2.
	
]

{ #category : #tests }
UsuarioTest >> testAgregarPregunta [
	"Se verifica la correcta adición de la pregunta en la colección de preguntas del usuario que es autor de ésta.
	El mensaje #agregarPregunta es enviado por la misma pregunta al usuario."

	|ask|
	
	self assert: user1 preguntas size equals: 1.
	ask := Pregunta conTopicos: { topic2. } titulo: 'test'  descripcion: 'testing...' usuario: user1.
	self assert: user1 preguntas size equals: 2.
	self assert: (user1 preguntas includes: ask).

]

{ #category : #tests }
UsuarioTest >> testAgregarRespuesta [
	"Se verifica la correcta adición de la respuesta en la colección de respuestas del usuario que es autor de ésta.
	El mensaje #agregarRespuesta es enviado por la misma respuesta al usuario."
	
	|ans|
	
	self assert: user1 respuestas size equals: 1.
	
	ans := ask3 crearRespuestaConTexto: 'test' usuario: user1.
	self assert: user1 respuestas size equals: 2.
	self assert: (user1 respuestas includes: ans).
	
]

{ #category : #tests }
UsuarioTest >> testAgregarTopicoDeInteres [
	"se verifica la correcta adición de tópicos de interés para el usuario."
	
	self assert: user1 cantidadDetopicosDeInteres equals: 0.
	user1 agregarTopicoDeInteres: topic1.
	user1 agregarTopicoDeInteres: topic2.
	self assert: user1 cantidadDetopicosDeInteres equals: 2.

	self assert: (user1 esTopicoDeInteres: topic1).
	self assert: (user1 esTopicoDeInteres: topic2).
	self deny: (user1 esTopicoDeInteres: topic3).
]

{ #category : #tests }
UsuarioTest >> testAgregarUsuarioParaSeguir [

	"Se verifica el correcto funcionamiento de la adición de un usuario a la colección de usuarios seguidos de un usuario."

	self assert: user1 cantidadDeUsuariosSeguidos equals: 0.
	user1 agregarUsuarioParaSeguir: user2.
	user1 agregarUsuarioParaSeguir: user3.
	self assert: user1 cantidadDeUsuariosSeguidos equals: 2.
	
	self deny: (user1 esUsuarioSeguido: user1).
	self assert: (user1 esUsuarioSeguido: user2).
	self assert: (user1 esUsuarioSeguido: user3).
]

{ #category : #tests }
UsuarioTest >> testBorrarLaPregunta [
	"Se verifica la correcta eliminación de una pregunta de la colección de preguntas del usuario.
	Este mensaje es enviado por el objeto pregunta cuando ésta se borra a si misma."

	|ask|

	self assert: (user1 borrarLaPregunta: ask3)	 equals: nil.
	ask := user1 borrarLaPregunta: ask1.
	self assert: (user1 borrarLaPregunta: ask1) equals: nil.
	self deny: (user1 preguntas includes: ask).

]

{ #category : #tests }
UsuarioTest >> testPreguntasPorFechaDescendente [
	"Se verifica el correcto funcionamiento del mensaje."
	|ask preguntas|

	ask1 fechaYHoraDeCreacion: '1999-01-30 12:40:35' asDateAndTime.
	
	ask := Pregunta conTopicos: { topic2. } titulo: 'test' descripcion: 'testing...' usuario: user1.
	ask fechaYHoraDeCreacion: '2021-07-30' asDateAndTime.
	preguntas := user1 preguntasPorFechaDescendente.
	
	self assert: preguntas size equals: 2.
	self assert: (preguntas first) equals: ask.
	self assert: (preguntas last) equals: ask1.
	self assert: (preguntas first fechaYHoraDeCreacion > preguntas last fechaYHoraDeCreacion).
	
]

{ #category : #tests }
UsuarioTest >> testPreguntasRelevantes [
	"Se verifica el correcto funcionamiento de la obtención de la colección de preguntas que son relevantes para un usuario."

	| preguntaNoRelevante preguntaRelevantePorSeguidor preguntaRelevantePorTopico preguntaRelevantePorTopicoYSegudor |
	user1 agregarTopicoDeInteres: topic1.
	user1 agregarUsuarioParaSeguir: user2.
	preguntaRelevantePorSeguidor := self crearPreguntaRelevante1.
	preguntaRelevantePorTopico := self crearPreguntaRelevante2.
	preguntaRelevantePorTopicoYSegudor := self crearPreguntaRelevante3.
	preguntaNoRelevante := self crearPreguntaNoRelevante.
	
	self assert: (user1 preguntasRelevantes includes: preguntaRelevantePorSeguidor).
	self assert: (user1 preguntasRelevantes includes: preguntaRelevantePorTopico).
	self assert: (user1 preguntasRelevantes includes: preguntaRelevantePorTopicoYSegudor).
	self deny: (user1 preguntasRelevantes includes: preguntaNoRelevante).
]

{ #category : #tests }
UsuarioTest >> testPuntaje [

	"Se verifica el correcto funcionamiento del puntaje de un usuario.E indirectamente el
	funcionamiento del mensaje #puntaje de la superclase Post."

	self assert: user1 puntaje equals: 21.
	self assert: user2 puntaje equals: 19.
	self assert: user3 puntaje equals: 122.
]

{ #category : #tests }
UsuarioTest >> testTuContrasenaEs [
	"Se verifica el correcto funcionamiento del mensaje en el cual importan las mayúsculas y minñusculas."
	|user|
	
	user := Usuario conNombre: 'test' contrasena: 'testing...'.
	self assert: (user tuContrasenaEs: 'testing...').
	self deny: (user tuContrasenaEs: 'tesTing...').
	self deny: (user tuContrasenaEs: '').
]

{ #category : #tests }
UsuarioTest >> testTuNombreEs [

	"Se verifica el correcto funcionamiento del mensaje, en el cual no importan mayúsculas o minúsculas."
	
	self assert: (user1 tuNombreEs: 'Juan Perez').
	self assert: (user1 tuNombreEs: 'jUAn pErEz').
	self deny: (user1 tuNombreEs: 'juan-perez').
]

{ #category : #tests }
UsuarioTest >> testUltimasPreguntasRelevantes [
	"Se verifica la correcta obtención de las preguntas según tópicos de interés y usuarios seguidos.
	Luego se verifica el orden cronológico descendente."

	|preguntas|

	self assert: user1 ultimasPreguntasRelevantes size equals: 0.
	user1 agregarTopicoDeInteres: topic1.
	self assert: user1 ultimasPreguntasRelevantes size equals: 2.
	user1 agregarUsuarioParaSeguir: user3.
	self assert: user1 ultimasPreguntasRelevantes size equals: 3.

	ask1 fechaYHoraDeCreacion: '1900-01-01 12:12:12' asDateAndTime.
	ask2 fechaYHoraDeCreacion: '2000-01-01 12:12:12' asDateAndTime.
	ask3 fechaYHoraDeCreacion: '2100-01-01 12:12:12' asDateAndTime.
	preguntas := user1 ultimasPreguntasRelevantes.
	
	self assert: preguntas first equals: ask3.
	self assert: preguntas last equals: ask1.
]
