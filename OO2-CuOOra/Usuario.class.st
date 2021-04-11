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
		'fechaHoraCreacion'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creating }
Usuario class >> conNombre: unNombreString contrasena: unaContrasenaString [
	^self new conNombre: unNombreString contrasena: unaContrasenaString
]

{ #category : #accessing }
Usuario >> agregarTopicoDeInteres: unTopico [
	^topicos add: unTopico
]

{ #category : #accessing }
Usuario >> agregarUsuarioParaSeguir: unUsuario [
	^usuariosSeguidos add: unUsuario
]

{ #category : #'methods for tests' }
Usuario >> cantidadDeUsuariosSeguidos [
	^usuariosSeguidos size.
]

{ #category : #'methods for tests' }
Usuario >> cantidadDetopicosDeInteres [
	^topicos size.
]

{ #category : #creating }
Usuario >> conNombre: unNombreString contrasena: unaContrasenaString [
	nombre := unNombreString.
	contrasena := unaContrasenaString
]

{ #category : #'methods for tests' }
Usuario >> contrasena [
	^ contrasena
]

{ #category : #'methods for tests' }
Usuario >> creacion [
	^ fechaHoraCreacion
]

{ #category : #accessing }
Usuario >> esRelevante: unaPregunta [
	^(self esRelevanteEnTopicos: unaPregunta) or: [ self esRelevanteEnSeguidos: unaPregunta ]
]

{ #category : #internal }
Usuario >> esRelevanteEnSeguidos: unaPregunta [
	^usuariosSeguidos anySatisfy: [ :unUsuario | unaPregunta esDelUsuario: unUsuario ]
]

{ #category : #internal }
Usuario >> esRelevanteEnTopicos: unaPregunta [
	^topicos anySatisfy: [ :unTopico | unaPregunta tieneElTopico: unTopico ]
]

{ #category : #initializing }
Usuario >> initialize [
	fechaHoraCreacion := DateAndTime now.
	usuariosSeguidos := OrderedCollection new.
	topicos := OrderedCollection new.
]

{ #category : #'methods for tests' }
Usuario >> nombre [
	^ nombre
]

{ #category : #'methods for tests' }
Usuario >> topicos [
	^ topicos
]

{ #category : #accessing }
Usuario >> tuContrasenaEs: unaContrasena [
	^contrasena match: unaContrasena
]

{ #category : #accessing }
Usuario >> tuNombreEs: unNombre [
	^nombre asLowercase match: unNombre asLowercase
]

{ #category : #'methods for tests' }
Usuario >> usuarios [
	^usuariosSeguidos
]
