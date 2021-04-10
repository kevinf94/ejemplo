"
.
"
Class {
	#name : #Pregunta,
	#superclass : #Post,
	#instVars : [
		'topicos',
		'titulo',
		'descripcion',
		'respuestas'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creation }
Pregunta class >> conTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario [
	((unosTopicos isNotNil) and: [ (unosTopicos isNotEmpty) ])
	ifTrue: [ ^self new conTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario ].
	self error: 'Falta al menos un t√≥pico.'.
]

{ #category : #accessing }
Pregunta >> cantidadDeRespuestas [
	^respuestas size
]

{ #category : #creation }
Pregunta >> conTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario [
	topicos := unosTopicos.
	titulo := unTitulo.
	descripcion := unaDescripcion.
	usuario := unUsuario.
]

{ #category : #accessing }
Pregunta >> crearRespuestaConTexto: unTexto usuario: unUsuario [
	respuestas add: (Respuesta conTexto: unTexto usuario: unUsuario)
]

{ #category : #'methods for tests' }
Pregunta >> descripcion [
	^descripcion
]

{ #category : #accessing }
Pregunta >> esTuUsuario: unUsuario [
	^usuario = unUsuario
]

{ #category : #initializing }
Pregunta >> initialize [
	super initialize.
	respuestas := OrderedCollection new.
	topicos := OrderedCollection new.
]

{ #category : #accessing }
Pregunta >> obtenerRespuestasDelUsuario: unUsuario [
	^respuestas select: [ :unaRespuesta | unaRespuesta esDelUsuario: unUsuario ]
]

{ #category : #'methods for tests' }
Pregunta >> respuestas [
	^respuestas
]

{ #category : #accessing }
Pregunta >> tieneElTopico: unTopico [
	^topicos anySatisfy: [ :esteTopico | esteTopico esElTopico: unTopico ]
]

{ #category : #'methods for tests' }
Pregunta >> titulo [
	^titulo
]

{ #category : #'methods for tests' }
Pregunta >> topicos [
	^topicos
]
