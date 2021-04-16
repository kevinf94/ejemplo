"
.
"
Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'contrasena',
		'usuariosSeguidos',
		'topicos',
		'preguntas',
		'respuestas',
		'fechaYHoraDeCreacion'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #'instance creation' }
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

{ #category : #accessing }
Usuario >> borrarLaPregunta: unaPregunta [
	^preguntas remove: unaPregunta ifAbsent: [ ^nil ].
]

{ #category : #'methods for tests' }
Usuario >> borrarLaRespuesta: unaRespuesta [
	^respuestas remove: unaRespuesta ifAbsent: [ ^nil ].
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

{ #category : #'instance creation' }
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
	^ fechaYHoraDeCreacion
]

{ #category : #'methods for tests' }
Usuario >> fechaYHoraDeCreacion: aDateAndTime [
	fechaYHoraDeCreacion := aDateAndTime 
]

{ #category : #initializing }
Usuario >> initialize [
	fechaYHoraDeCreacion := DateAndTime now.
	usuariosSeguidos := Set new.
	topicos := Set new.
	preguntas := Set new.
	respuestas := Set new.
]

{ #category : #'methods for tests' }
Usuario >> nombre [
	"Retorna el nombre del usuario."
	^ nombre
]

{ #category : #accessing }
Usuario >> preguntas [ 
	^preguntas
]

{ #category : #private }
Usuario >> preguntasConTopicosDeInteres [
	^topicos flatCollect: [ :unTopico | unTopico preguntas. ].
]

{ #category : #private }
Usuario >> preguntasDeUsuariosSeguidos [
	^usuariosSeguidos flatCollect: [ :unUsuario | unUsuario preguntas ]
]

{ #category : #accessing }
Usuario >> preguntasPorFechaDescendente [
	^preguntas asSortedCollection: [ :a :b | a fechaYHoraDeCreacion > b fechaYHoraDeCreacion ]
]

{ #category : #accessing }
Usuario >> preguntasRelevantes [
	|relevantes|
	relevantes := Set new.
	relevantes addAll: self preguntasConTopicosDeInteres.
	relevantes addAll: self preguntasDeUsuariosSeguidos.
	^relevantes asSortedCollection: [ :a :b | a fechaYHoraDeCreacion > b fechaYHoraDeCreacion ].

]

{ #category : #accessing }
Usuario >> puntaje [
	^self puntajePorPreguntasPublicadas + self respuestasAOtrosUsuarios + self puntajePorVotosDePreguntasPublicadas + self puntajePorVotosDeRespuestasPublicadas
]

{ #category : #private }
Usuario >> puntajePorPreguntasPublicadas [
	^preguntas * 20.
]

{ #category : #private }
Usuario >> puntajePorRespuestasPublicadas [
	^self respuestasAOtrosUsuarios * 50.
]

{ #category : #private }
Usuario >> puntajePorVotosDePreguntasPublicadas [
	^preguntas sumNumbers: [ :unaPregunta | unaPregunta puntaje ].
]

{ #category : #private }
Usuario >> puntajePorVotosDeRespuestasPublicadas [
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

{ #category : #accessing }
Usuario >> respuestas [
	^respuestas
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

{ #category : #accessing }
Usuario >> ultimasPreguntasRelevantes [
	"Retorna las primeras 5 preguntas mas recientemente creadas que son relevantes para el usuario."
	|top5|
	top5 := self preguntasRelevantes asSortedCollection: [ :a :b | a fechaYHoraDeCreacion > b fechaYHoraDeCreacion ].
	^top5 first: (5 min: (top5 size)).
]

{ #category : #'methods for tests' }
Usuario >> usuariosSeguidos [
	"Retorna la colección de usuarios seguidos del usuario."
	^usuariosSeguidos
]
