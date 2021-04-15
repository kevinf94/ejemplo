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
		'topicos'
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
CuOOra >> agregarTopicoConNombre: unNombreString descripcion: unaDescripcionString [
	"Se crea un tópico y se lo agrega a la colección de tópicos del sistema. Se retorna el tópico creado."
	^topicos add: (Topico conNombre: unNombreString descripcion: unaDescripcionString)
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
	usuarios := Set new.
	topicos := Set new.
	
	self mySetUp.
	self mySetUp2.

]

{ #category : #'methods for tests' }
CuOOra >> mySetUp [
	"set up para testing"
	|user1 user2 user3 user4 ask1 ask2 ask3 ask4 ask5 ans1 topic1 topic2 topic3 topic4 topic5 topic6 topic7|
	
	topic1 := topicos add: (Topico conNombre: 'topic1' descripcion: 'desc1').
	topic2 := topicos add: (Topico conNombre: 'topic2' descripcion: 'desc2').
	topic3 := topicos add: (Topico conNombre: 'topic3' descripcion: 'desc3').
	topic4 := topicos add: (Topico conNombre: 'topic4' descripcion: 'desc4').
	topic5 := topicos add: (Topico conNombre: 'topic5' descripcion: 'desc5').
	topic6 := topicos add: (Topico conNombre: 'topic6' descripcion: 'desc6').
	topic7 := topicos add: (Topico conNombre: 'topic7' descripcion: 'desc7').
	
	user1 := usuarios add: (Usuario conNombre: 'user1' contrasena: 'pass1').
	user2 := usuarios add: (Usuario conNombre: 'user2' contrasena: 'pass2').
	user3 := usuarios add: (Usuario conNombre: 'user3' contrasena: 'pass3').
	user4 := usuarios add: (Usuario conNombre: 'user4' contrasena: 'pass4').
	
	user1 agregarTopicoDeInteres: topic3.
	user1 agregarTopicoDeInteres: topic5.
	user1 agregarUsuarioParaSeguir: user2.
	ask1 := Pregunta conTopicos: {topic1.} titulo: 'pregunta1' descripcion: 'descripcion pregunta1' usuario: user1.
	ask1 fechaYHoraDeCreacion: '1998-05-20 13:50:20' asDateAndTime.
	ask2 := Pregunta conTopicos: {topic2.} titulo: 'pregunta2' descripcion: 'descripcion pregunta2' usuario: user1.
	ask2 fechaYHoraDeCreacion: '1999-05-20 13:50:20' asDateAndTime.
	
	user2 agregarTopicoDeInteres: topic1.
	user2 agregarTopicoDeInteres: topic4.
	user2 agregarUsuarioParaSeguir: user1.
	ask3 := Pregunta conTopicos: {topic3.} titulo: 'pregunta3' descripcion: 'descripcion pregunta3' usuario: user2.
	ask3 fechaYHoraDeCreacion: '2000-05-20 13:50:20' asDateAndTime.
	ask4 := Pregunta conTopicos: {topic4.} titulo: 'pregunta4' descripcion: 'descripcion pregunta4' usuario: user2.
	ask4 fechaYHoraDeCreacion: '2001-05-20 13:50:20' asDateAndTime.
	
	user3 agregarTopicoDeInteres: topic6.
	user3 agregarTopicoDeInteres: topic7.
	user3 agregarUsuarioParaSeguir: user2.
	ask5 := Pregunta conTopicos: {topic5.} titulo: 'pregunta5' descripcion: 'descripcion pregunta5' usuario: user3.
	ask5 fechaYHoraDeCreacion: '2002-05-20 13:50:20' asDateAndTime.

	ask4 agregarLikeDelUsuario: user1.
	ask4 agregarLikeDelUsuario: user2.
	ans1 := ask4 crearRespuestaConTexto: 'respuesta a la pregunta4'  usuario: user4.
	ans1 fechaYHoraDeCreacion: '2003-05-20 13:50:20' asDateAndTime.
	
	ask5 agregarDislikeDelUsuario: user1.


]

{ #category : #'methods for tests' }
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
	
	ask1 := '¿Para qué sirve el m√©todo SetUp?'.
	ask1 := Pregunta conTopicos: {topic1. topic2.} titulo: ask1 descripcion: '' usuario: user1.
	ask2 := '¿Qué significa #messageNotUnderstood?'.
	ask2 := Pregunta conTopicos: {topic1. topic3.} titulo: ask2 descripcion: '' usuario: user2.

	ans1 := 'Sirve para instanciar los objetos que son evaluados por el test en un único método y que se ejecute siempre antes de cada test'.
	ans1 := ask1 crearRespuestaConTexto: ans1 usuario: user2.

	ans2 := 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta'.
	ans2 := ask2 crearRespuestaConTexto: ans2 usuario: user1.

]

{ #category : #'methods for tests' }
CuOOra >> tenesElTopico: unTopico [
	"Retorna verdadro/falso si la colección de tópicos contiene un tópico determinado."
	^topicos includes: unTopico
]

{ #category : #accessing }
CuOOra >> topicos [
	"Retorna la colección de tópicos."
	^ topicos
]

{ #category : #accessing }
CuOOra >> userWithName: unNombre protectedBy: unaContrasena [
	"Dado un nombre y contraseña, verifica que existe el nombre indicado y su contraseña es
	la indicada y retorna el usuario, de lo contrario, retorna el valor nil."
	^ usuarios
		detect: [ :unUsuario | (unUsuario tuNombreEs: unNombre) and: [ (unUsuario tuContrasenaEs: unaContrasena) ] ]
		ifNone: [ nil ]
]

{ #category : #'methods for tests' }
CuOOra >> usuarios [
	^usuarios
]
