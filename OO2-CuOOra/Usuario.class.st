"
.
"
Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'contrasena',
		'fechaHoraCreacion',
		'usuariosSeguidos',
		'topicos',
		'preguntas',
		'respuestas'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creating }
Usuario class >> conNombre: unNombreString contrasena: unaContrasenaString [
	^self new conNombre: unNombreString contrasena: unaContrasenaString
]

{ #category : #accessing }
Usuario >> agregarPregunta: unaPregunta [
	^preguntas add: unaPregunta.
]

{ #category : #accessing }
Usuario >> agregarRespuesta: unaRespuesta [
	^respuestas add: unaRespuesta.
]

{ #category : #accessing }
Usuario >> agregarTopicoDeInteres: unTopico [
	"Agrega un tópico a la colección de tópicos de interés del usuario."
	^topicos add: unTopico
]

{ #category : #accessing }
Usuario >> agregarUsuarioParaSeguir: unUsuario [
	"Agrega un usuario a la colección de 'usuarios a seguir' del usuario."
	^usuariosSeguidos add: unUsuario
]

{ #category : #'methods for tests' }
Usuario >> cantidadDeUsuariosSeguidos [
	"Retorna la cantidad de usuarios seguidos del usuario."
	^usuariosSeguidos size.
]

{ #category : #'methods for tests' }
Usuario >> cantidadDetopicosDeInteres [
	"Retorna la cantida de tópicos de interés del usuario."
	^topicos size.
]

{ #category : #creating }
Usuario >> conNombre: unNombreString contrasena: unaContrasenaString [
	"Constructor."
	nombre := unNombreString.
	contrasena := unaContrasenaString
]

{ #category : #'methods for tests' }
Usuario >> contrasena [
	"Retorna la contraseña del usuario."
	^ contrasena
]

{ #category : #'methods for tests' }
Usuario >> dejarDeSeguirAlUsuario: unUsuario [
	"Elimina de la colección de 'usuarios seguidos' a un determinado usuario y lo retorna.
	De no existir, retorna el valor nil."
	^usuariosSeguidos remove: unUsuario ifAbsent: [ ^nil ].

]

{ #category : #'methods for tests' }
Usuario >> esTopicoDeInteres: unTopico [
	^topicos includes: unTopico
]

{ #category : #'methods for tests' }
Usuario >> esUsuarioSeguido: unUsuario [
	^usuariosSeguidos includes: unUsuario
]

{ #category : #'methods for tests' }
Usuario >> fechaYHoraDeCreacion [
	"Retorna la fecha y hora en que se creó el usuario."
	^ fechaHoraCreacion
]

{ #category : #initializing }
Usuario >> initialize [
	fechaHoraCreacion := DateAndTime now.
	usuariosSeguidos := OrderedCollection new.
	topicos := OrderedCollection new.
]

{ #category : #'methods for tests' }
Usuario >> nombre [
	"Retorna el nombre del usuario."
	^ nombre
]

{ #category : #accessing }
Usuario >> preguntasRelevantes [
	|preguntasDeUsuariosSeguidos preguntasDeTopicosDeInteres|
	preguntasDeUsuariosSeguidos := usuariosSeguidos flatCollect: [ :unUsuario | unUsuario preguntas ] asSet.
	preguntasDeTopicosDeInteres := topicos flatCollect: [ :unTopico | unTopico preguntas. ] asSet.
	preguntasDeUsuariosSeguidos addAll: preguntasDeTopicosDeInteres.
	^preguntasDeUsuariosSeguidos asSortedCollection: [ :a :b | a fechaYHoraDeCreacion > b fechaYHoraDeCreacion ].

]

{ #category : #accessing }
Usuario >> puntaje [
	^self puntajePreguntas + self respuestasAOtrosUsuarios + self puntajePreguntasVotos + self puntajeRespuestasVotos
]

{ #category : #private }
Usuario >> puntajePreguntas [
	^preguntas * 20.
]

{ #category : #private }
Usuario >> puntajePreguntasVotos [
	^preguntas sumNumbers: [ :unaPregunta | unaPregunta puntaje ].
]

{ #category : #private }
Usuario >> puntajeRespuestas [
	^self respuestasAOtrosUsuarios * 50.
]

{ #category : #private }
Usuario >> puntajeRespuestasVotos [
	^self respuestasAOtrosUsuarios sumNumbers: [ :unaRespuesta | unaRespuesta puntaje. ].
]

{ #category : #'methods for tests' }
Usuario >> quitarTopicoDeInteres: unTopico [
	"Elimina un tópico de la colección de tópicos de interés del usuario y lo retorna.
	De no existir, retorna el valor nil."
	^topicos remove: unTopico ifAbsent: [ ^nil. ].

]

{ #category : #private }
Usuario >> respondiAMiPreguntaCon: unaRespuesta [
	^preguntas anySatisfy: [ :unaPregunta | unaPregunta includes: unaRespuesta ].
]

{ #category : #private }
Usuario >> respuestasAOtrosUsuarios [
	^respuestas reject: [ :miRespuesta | self respondiAMiPreguntaCon: miRespuesta ]
]

{ #category : #'methods for tests' }
Usuario >> topicos [
	"Retorna la colección de tópicos de interés del usuario."
	^ topicos
]

{ #category : #accessing }
Usuario >> tuContrasenaEs: unaContrasena [
	"Retorna verdadero/falso si la contraseña indicada es la del usuario."
	^contrasena match: unaContrasena
]

{ #category : #accessing }
Usuario >> tuNombreEs: unNombre [
	"Retorna verdadero/falso si el nombre indicado es el del usuario."
	^nombre asLowercase match: unNombre asLowercase
]

{ #category : #'methods for tests' }
Usuario >> usuariosSeguidos [
	"Retorna la colección de usuarios seguidos del usuario."
	^usuariosSeguidos
]
