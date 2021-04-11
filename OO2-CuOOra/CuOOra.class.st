"
|miAplicacion|
CuOOra clearSoleInstance.
WAAdmin unregister: 'cuoora'.
miAplicacion := WAAdmin register: CuOOraLoginComponent asApplicationAt: 'cuoora'.
miAplicacion sessionClass: CuOOraSessionWithUser.
CuOOra allInstances.
"
Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos',
		'preguntas'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #'instance creation' }
CuOOra class >> clearSoleInstance [
	soleInstance := nil
]

{ #category : #'instance creation' }
CuOOra class >> soleInstance [
	^soleInstance ifNil: [ soleInstance := self new. ]


]

{ #category : #accessing }
CuOOra >> agregarPreguntaConTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario [
	^preguntas add: (Pregunta conTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario)
]

{ #category : #accessing }
CuOOra >> agregarRespuestaParaLaPregunta: unaPregunta texto: unTexto usuario: unUsuario [
	^unaPregunta crearRespuestaConTexto: unTexto usuario: unUsuario
]

{ #category : #accessing }
CuOOra >> agregarTopicoConNombre: unNombreString descripcion: unaDescripcionString [
	^topicos add: (Topico conNombre: unNombreString descripcion: unaDescripcionString)
]

{ #category : #accessing }
CuOOra >> agregarTopicoDeInteres: unTopico paraElUsuario: unUsuario [
	^unUsuario agregarTopicoDeInteres: unTopico
]

{ #category : #accessing }
CuOOra >> borrarLaPregunta: unaPregunta [
	^preguntas remove: unaPregunta.
]

{ #category : #accessing }
CuOOra >> crearUnNuevoUsuarioConNombre: unNombreString contrasena: unaContrasenaString [
	^usuarios add: (Usuario conNombre: unNombreString contrasena: unaContrasenaString).
]

{ #category : #accessing }
CuOOra >> existeUsuarioConNombre: unNombre [
	^ usuarios anySatisfy: [ :unUsuario | (unUsuario tuNombreEs: unNombre) ]
	
]

{ #category : #initializing }
CuOOra >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	preguntas := OrderedCollection new.
	
	self mySetUp.
	self mySetUp2.

]

{ #category : #initializing }
CuOOra >> mySetUp [
	|unUsuario unaPregunta unosTopicos|
	
	1 to: 20 do: [ :x | usuarios add: (Usuario conNombre: ('user',x asString) contrasena: ('pass',x asString)) ].
	
	1 to: 20 do: [ :y | topicos add: (Topico conNombre: ('topico',y asString) descripcion: ('descripcion del topico',y asString)) ].
	
	unUsuario := usuarios at: 1.
	unUsuario agregarTopicoDeInteres: (topicos at: 3).
	unUsuario agregarTopicoDeInteres: (topicos at: 5).
	unUsuario agregarUsuarioParaSeguir: (usuarios at: 2).
	1 to: 2 do: [ :a | 
		unosTopicos := OrderedCollection with: (topicos at: a).
		preguntas add: (Pregunta conTopicos: unosTopicos titulo: 'pregunta',a asString descripcion: 'descripcion pregunta',a asString usuario: unUsuario)
		].
	
	unUsuario := usuarios at: 2.
	unUsuario agregarTopicoDeInteres: (topicos at: 1).
	unUsuario agregarTopicoDeInteres: (topicos at: 4).
	unUsuario agregarUsuarioParaSeguir: (usuarios at: 1).
	3 to: 4 do: [ :b | 
		unosTopicos := OrderedCollection with: (topicos at: b).
		self agregarPreguntaConTopicos: unosTopicos titulo: 'pregunta',b asString descripcion: 'descripcion pregunta',b asString usuario: unUsuario
		].
	
	unUsuario := usuarios at: 3.
	unUsuario agregarTopicoDeInteres: (topicos at: 6).
	unUsuario agregarTopicoDeInteres: (topicos at: 7).
	unUsuario agregarUsuarioParaSeguir: (usuarios at: 2).
	5 to: 6 do: [ :b | 
		unosTopicos := OrderedCollection with: (topicos at: b).
		self agregarPreguntaConTopicos: unosTopicos titulo: 'pregunta',b asString descripcion: 'descripcion pregunta',b asString usuario: unUsuario
		].

	unaPregunta := preguntas at: 4.
	unaPregunta agregarLikeDelUsuario: (usuarios at: 1).
	unaPregunta agregarLikeDelUsuario: (usuarios at: 2).
	self agregarRespuestaParaLaPregunta: unaPregunta texto: 'respuesta a la pregunta4'  usuario: (usuarios at: 7).
	
	unaPregunta := preguntas at: 5.
	unaPregunta agregarDislikeDelUsuario: (usuarios at: 1).


]

{ #category : #initializing }
CuOOra >> mySetUp2 [
	"Contenido prefijado de CuOOra para la correcci√≥n del trabajo pr√°ctico 1."
	
	|user1 user2 user3 topic1 topic2 topic3 ask1 ask2 ans1 ans2|
	
	user1 := 'pedro@cuoora.com'.
	user1 := self crearUnNuevoUsuarioConNombre: user1 contrasena: user1.
	user2 := 'diego@cuoora.com'.
	user2 := self crearUnNuevoUsuarioConNombre: user2 contrasena: user2.
	user3 := 'juan@cuoora.com'.	
	user3 := self crearUnNuevoUsuarioConNombre: user3 contrasena: user3.
	
	user3 agregarUsuarioParaSeguir: user2.
	user1 agregarUsuarioParaSeguir: user3.
	
	topic1 := self agregarTopicoConNombre: 'OO1' descripcion: ''.
	topic2 := self agregarTopicoConNombre: 'Test de unidad' descripcion: ''.
	topic3 := self agregarTopicoConNombre: 'Smalltalk' descripcion: ''.
	
	ask1 := '¬øPara qu√© sirve el m√©todo SetUp?'.
	ask1 := self agregarPreguntaConTopicos: {topic1. topic2.} titulo: ask1 descripcion: '' usuario: user1.
	ask2 := '¬øQu√© significa #messageNotUnderstood?'.
	ask2 := self agregarPreguntaConTopicos: {topic1. topic3.} titulo: ask2 descripcion: '' usuario: user2.

	ans1 := 'Sirve para instanciar los objetos que son evaluados por el test en un √∫nico m√©todo y que se ejecute siempre antes de cada test'.
	self agregarRespuestaParaLaPregunta: ask1 texto: ans1 usuario: user2.
	ans2 := 'Significa que el objeto que recibi√≥ el mensaje no encontr√≥ ning√∫n m√©todo para ejecutar en respuesta'.
	self agregarRespuestaParaLaPregunta: ask2 texto: ans2 usuario: user1.

]

{ #category : #accessing }
CuOOra >> obtenerLasPreguntasConElTopico: unTopico [
	^preguntas select: [ :unaPregunta | unaPregunta tieneElTopico: unTopico ]
	
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasRelevantesParaElUsuario: unUsuario [
	^preguntas select: [ :unaPregunta | unUsuario esRelevante: unaPregunta ]
]

{ #category : #accessing }
CuOOra >> obtenerPuntajeDelUsuario: unUsuario [
	|lasPreguntas puntajePreguntas lasRespuestas puntajeRespuestas|
	lasPreguntas := self preguntasDelUsuario: unUsuario.
	lasRespuestas := self respuestasAOtrosUsuariosDelUsuario: unUsuario.
	puntajePreguntas := lasPreguntas sumNumbers: [ :unaPost | unaPost puntaje ].
	puntajeRespuestas := lasRespuestas sumNumbers: [ :unaPost | unaPost puntaje ].
	^(lasPreguntas size * 20) + (lasRespuestas size * 50) + puntajePreguntas + puntajeRespuestas
]

{ #category : #accessing }
CuOOra >> obtenerRespuestasDeLaPregunta: unaPregunta [
	^unaPregunta respuestas asSortedCollection: [ :unaRespuesta :otraRespuesta | unaRespuesta puntaje > otraRespuesta puntaje ]
]

{ #category : #'methods for tests' }
CuOOra >> preguntas [
	^ preguntas
]

{ #category : #accessing }
CuOOra >> preguntasDelUsuario: unUsuario [
	^preguntas select: [ :unaPregunta | unaPregunta esTuUsuario: unUsuario ]
]

{ #category : #internal }
CuOOra >> preguntasQueNoSonDelUsuario: unUsuario [
	^preguntas reject: [ :unaPregunta | unaPregunta esDelUsuario: unUsuario ]
]

{ #category : #internal }
CuOOra >> respuestasAOtrosUsuariosDelUsuario: unUsuario [
	|otrasPreguntas|
	otrasPreguntas := (self preguntasQueNoSonDelUsuario: unUsuario).
	^otrasPreguntas flatCollect: [ :unaPregunta | unaPregunta obtenerRespuestasDelUsuario: unUsuario ]

]

{ #category : #accessing }
CuOOra >> respuestasDelUsuario: unUsuario [
	^preguntas flatCollect: [ :unaPregunta | unaPregunta obtenerRespuestasDelUsuario: unUsuario ]
]

{ #category : #'methods for tests' }
CuOOra >> topicos [
	^ topicos
]

{ #category : #accessing }
CuOOra >> ultimas: cantidad PreguntasRelevantesParaElUsuario: unUsuario [
	|relevantes|
	relevantes := (self obtenerPreguntasRelevantesParaElUsuario: unUsuario) asSortedCollection: [ :a :b | a creacion > b creacion ].
	^relevantes first: (cantidad min: relevantes size)
]

{ #category : #accessing }
CuOOra >> userWithName: unNombre protectedBy: unaContrasena [
	^ usuarios
		detect: [ :unUsuario | (unUsuario tuNombreEs: unNombre) and: [ (unUsuario tuContrasenaEs: unaContrasena) ] ]
		ifNone: [ nil ]
]

{ #category : #'methods for tests' }
CuOOra >> usuarios [
	^ usuarios
]
