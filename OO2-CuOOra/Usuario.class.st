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
Usuario >> creacion [
	"Retorna la fecha y hora en que se creó el usuario."
	^ fechaHoraCreacion
]

{ #category : #'methods for tests' }
Usuario >> dejarDeSeguirAlUsuario: unUsuario [
	"Elimina de la colección de 'usuarios seguidos' a un determinado usuario y lo retorna.
	De no existir, retorna el valor nil."
	^usuariosSeguidos remove: unUsuario ifAbsent: [ ^nil ].

]

{ #category : #accessing }
Usuario >> esRelevante: unaPregunta [
	"Retorna verdadero/falso si la pregunta indicada es de relevancia para el usuario."
	^(self esRelevanteEnTopicos: unaPregunta) or: [ self esRelevanteEnSeguidos: unaPregunta ]
]

{ #category : #internal }
Usuario >> esRelevanteEnSeguidos: unaPregunta [
	"Retorna verdadero/falso si la pregunta indicada es de relevancia. Basándose en los usuarios seguidos."
	^usuariosSeguidos anySatisfy: [ :unUsuario | unaPregunta esDelUsuario: unUsuario ]
]

{ #category : #internal }
Usuario >> esRelevanteEnTopicos: unaPregunta [
	"Retorna verdadero/falso si la pregunta indicada es de relevancia. Basándose en los tópicos de interés."
	^topicos anySatisfy: [ :unTopico | unaPregunta tieneElTopico: unTopico ]
]

{ #category : #'methods for tests' }
Usuario >> esTopicoDeInteres: unTopico [
	^topicos includes: unTopico
]

{ #category : #'methods for tests' }
Usuario >> esUsuarioSeguido: unUsuario [
	^usuariosSeguidos includes: unUsuario
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

{ #category : #'methods for tests' }
Usuario >> quitarTopicoDeInteres: unTopico [
	"Elimina un tópico de la colección de tópicos de interés del usuario y lo retorna.
	De no existir, retorna el valor nil."
	^topicos remove: unTopico ifAbsent: [ ^nil. ].

]

{ #category : #'methods for tests' }
Usuario >> topicos [
	"Retorna la colección de tópicos de interés del usuario."
	^ topicos
]

{ #category : #'methods for tests' }
Usuario >> topicos: unosTopicos [
	topicos := unosTopicos
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
