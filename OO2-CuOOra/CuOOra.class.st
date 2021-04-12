"
|miAplicacion|
CuOOra clearSoleInstance.
WAAdmin unregister: 'cuoora'.
miAplicacion := WAAdmin register: CuOOraLoginComponent asApplicationAt: 'cuoora'.
miAplicacion sessionClass: CuOOraSessionWithUser.
CuOOra allInstances.

verificar que el nombre de usuario no existe en crearUsuario...
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
	"Se le pasan a la clase Pregunta los datos para crear una pregunta, y se agrega a la colección de preguntas del sistema y se retorna."
	^preguntas add: (Pregunta conTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario)
]

{ #category : #accessing }
CuOOra >> agregarRespuestaParaLaPregunta: unaPregunta texto: unTexto usuario: unUsuario [
	"metodo que ya no sirve porque existe la interfaz web?"
	"Se le indica a la instancia de pregunta que tiene que crear una respuesta con los datos indicados."
	^unaPregunta crearRespuestaConTexto: unTexto usuario: unUsuario
]

{ #category : #accessing }
CuOOra >> agregarTopicoConNombre: unNombreString descripcion: unaDescripcionString [
	"Se crea un tópico y se lo agrega a la colección de tópicos del sistema. Se retorna el tópico creado."
	^topicos add: (Topico conNombre: unNombreString descripcion: unaDescripcionString)
]

{ #category : #accessing }
CuOOra >> agregarTopicoDeInteres: unTopico paraElUsuario: unUsuario [
	"metodo que ya no sirve porque ahora existe la interfaz web?"
	"Se le indica a un usuario que debe agregar un tópico a su colección de tópicos."
	^unUsuario agregarTopicoDeInteres: unTopico
]

{ #category : #accessing }
CuOOra >> borrarLaPregunta: unaPregunta [
	"Se elimina una pregunta de la colección de pregutnas del sistema.
	Se retorna la pregunta eliminada o nil si no existe esa pregunta."
	^preguntas remove: unaPregunta ifAbsent: [ ^nil. ]
	
]

{ #category : #accessing }
CuOOra >> crearUnNuevoUsuarioConNombre: unNombreString contrasena: unaContrasenaString [
	"deberia verificar la existencia del nombre?
	(self existeUsuarioConNombre: unNombreString) ifTrue: [ ^nil. ]."
	
	"Crea y agrega un nuevo usuario a la colección de usuarios del sistema. Se retorna el nuevo usuario."
	^usuarios add: (Usuario conNombre: unNombreString contrasena: unaContrasenaString).
]

{ #category : #accessing }
CuOOra >> existeUsuarioConNombre: unNombre [
	"verifica si existe un usuario con el nombre indicado"
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
	"set up para testing"
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
	"Contenido prefijado de CuOOra para la corrección del trabajo práctico 1."
	
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
	
	ask1 := '¿Para qué sirve el método SetUp?'.
	ask1 := self agregarPreguntaConTopicos: {topic1. topic2.} titulo: ask1 descripcion: '' usuario: user1.
	ask1 fechaHoraCreacion: '2021-04-12 17:10' asDateAndTime.
	ask2 := '¿Qué significa #messageNotUnderstood?'.
	ask2 := self agregarPreguntaConTopicos: {topic1. topic3.} titulo: ask2 descripcion: '' usuario: user2.
	ask1 fechaHoraCreacion: '2021-04-11 09:45' asDateAndTime.

	ans1 := 'Sirve para instanciar los objetos que son evaluados por el test en un único método y que se ejecute siempre antes de cada test'.
	ans1 := self agregarRespuestaParaLaPregunta: ask1 texto: ans1 usuario: user2.
	ans1 fechaHoraCreacion: '2021-04-12 20:00' asDateAndTime.
	ans2 := 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta'.
	ans2 fechaHoraCreacion: '2021-04-12 13:00:11' asDateAndTime.
	ans2 := self agregarRespuestaParaLaPregunta: ask2 texto: ans2 usuario: user1.

]

{ #category : #accessing }
CuOOra >> obtenerLasPreguntasConElTopico: unTopico [
	"Retorna una colección con todas las preguntas que contingan el tópico indicado."
	^preguntas select: [ :unaPregunta | unaPregunta tieneElTopico: unTopico ]
	
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasRelevantesParaElUsuario: unUsuario [
	"Retorna una colección con todas las preguntas que contienen alguno de los tópicos que son de interés
	apra un usuario, junto con todas las preguntas realizadas por los otros usuarios que éste sigue."
	^preguntas select: [ :unaPregunta | unUsuario esRelevante: unaPregunta ]
]

{ #category : #accessing }
CuOOra >> obtenerPuntajeDelUsuario: unUsuario [
	"acoplamiento?????"
	"Midiante las preguntas, respuestas, y los votos que recibió, se calcula el puntaje de un usuario."
	|lasPreguntas puntajePreguntas lasRespuestas puntajeRespuestas|
	lasPreguntas := self preguntasDelUsuario: unUsuario.
	lasRespuestas := self respuestasAOtrosUsuariosDelUsuario: unUsuario.
	puntajePreguntas := lasPreguntas sumNumbers: [ :unaPost | unaPost puntaje ].
	puntajeRespuestas := lasRespuestas sumNumbers: [ :unaPost | unaPost puntaje ].
	^(lasPreguntas size * 20) + (lasRespuestas size * 50) + puntajePreguntas + puntajeRespuestas
]

{ #category : #accessing }
CuOOra >> obtenerRespuestasDeLaPregunta: unaPregunta [
	"debería estar este mensaje dentro de la clase Pregunta? es envidia de atributos?
	unaPregunta obtenerRespuestasOrdenadasPorPuntajeDeMayorAMenor????"
	
	"Retorna una colección de respuestas a una determinada pregunta."
	^unaPregunta respuestas asSortedCollection: [ :unaRespuesta :otraRespuesta | unaRespuesta puntaje > otraRespuesta puntaje ]
]

{ #category : #accessing }
CuOOra >> preguntas [
	"Retorna la colección de preguntas del sistema."
	^ preguntas
]

{ #category : #accessing }
CuOOra >> preguntasDelUsuario: unUsuario [
	"Retorna una colección de preguntas realizadas por el usurio indicado."
	^preguntas select: [ :unaPregunta | unaPregunta esTuUsuario: unUsuario ]
]

{ #category : #internal }
CuOOra >> preguntasQueNoSonDelUsuario: unUsuario [
	"Retorna una colección de preguntas que no fueron realizadas por el usuario indicado."
	^preguntas reject: [ :unaPregunta | unaPregunta esDelUsuario: unUsuario ]
]

{ #category : #internal }
CuOOra >> respuestasAOtrosUsuariosDelUsuario: unUsuario [
	"Retorna una colección de respuestas que hizo un usuario determinado, respuestas que son a preguntas de otros usuarios."
	|otrasPreguntas|
	otrasPreguntas := (self preguntasQueNoSonDelUsuario: unUsuario).
	^otrasPreguntas flatCollect: [ :unaPregunta | unaPregunta obtenerRespuestasDelUsuario: unUsuario ]

]

{ #category : #accessing }
CuOOra >> respuestasDelUsuario: unUsuario [
	"Retorna una colección de respuestas que realizo un usuario determinado."
	^preguntas flatCollect: [ :unaPregunta | unaPregunta obtenerRespuestasDelUsuario: unUsuario ]
]

{ #category : #'methods for tests' }
CuOOra >> tenesElTopico: unTopico [
	"Retorna verdadro/falso si la colección de tópicos contiene un tópico determinado."
	^topicos includes: unTopico
]

{ #category : #'methods for tests' }
CuOOra >> tenesLaPregunta: unaPregunta [
	"Retorna verdadro/falso si la colección de preguntas contiene una pregunta determinada."
	^preguntas includes: unaPregunta 
]

{ #category : #accessing }
CuOOra >> topicos [
	"Retorna la colección de tópicos."
	^ topicos
]

{ #category : #accessing }
CuOOra >> ultimas: cantidad PreguntasRelevantesParaElUsuario: unUsuario [
	"Retorna una colección con una cnatidad específica de las últimas preguntas creadas que son relevantes para un usuario."
	|relevantes|
	relevantes := (self obtenerPreguntasRelevantesParaElUsuario: unUsuario) asSortedCollection: [ :a :b | a creacion > b creacion ].
	^relevantes first: (cantidad min: relevantes size)
]

{ #category : #accessing }
CuOOra >> userWithName: unNombre protectedBy: unaContrasena [
	"Dado un nombre y contraseña, verifica que existe el nombre indicado y su contraseña es
	la indicada y retorna el usuario, de lo contrario, retorna el valor nil."
	^ usuarios
		detect: [ :unUsuario | (unUsuario tuNombreEs: unNombre) and: [ (unUsuario tuContrasenaEs: unaContrasena) ] ]
		ifNone: [ nil ]
]
