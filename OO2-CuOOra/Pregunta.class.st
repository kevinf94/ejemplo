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

{ #category : #'methods for tests' }
Pregunta >> borrarRespuesta: unaRespuesta [
	"Elimina una respuesta de la colección de respuesta y la retona. Si no existía, retorna el valor nil."
	^respuestas remove: unaRespuesta ifAbsent: [ ^nil. ].
]

{ #category : #accessing }
Pregunta >> cantidadDeRespuestas [
	"Retorna la cantida de respuestas de la pregunta."
	^respuestas size
]

{ #category : #creation }
Pregunta >> conTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: unUsuario [
	"Constructor."
	topicos := unosTopicos.
	titulo := unTitulo.
	descripcion := unaDescripcion.
	usuario := unUsuario.
]

{ #category : #accessing }
Pregunta >> crearRespuestaConTexto: unTexto usuario: unUsuario [
	"Crea una respuesta y la agrega a su colección de respuestas. Luego retorna la respuesta."
	^respuestas add: (Respuesta conTexto: unTexto usuario: unUsuario)
]

{ #category : #'methods for tests' }
Pregunta >> descripcion [
	"Retorna la descripción de la pregunta."
	^descripcion
]

{ #category : #accessing }
Pregunta >> esTuUsuario: unUsuario [
	"Retorna verdadero/falso si el usuario es el creador de la pregunta.
	El usuario es un atributo heredado."
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
	"Retorna una colección con las respuestas que pertenecen a un usuario determinado."
	^respuestas select: [ :unaRespuesta | unaRespuesta esDelUsuario: unUsuario ]
]

{ #category : #accessing }
Pregunta >> respuestas [
	"Retorna la colección de respuestas de la pregunta."
	^respuestas
]

{ #category : #'methods for tests' }
Pregunta >> tenesLaRespuesta: unaRespuesta [
	"Retorna verdadero/falso si la pregunta contiene la respuesta indicada."
	^respuestas includes: unaRespuesta
]

{ #category : #accessing }
Pregunta >> tieneElTopico: unTopico [
	"Retorna verdadero/falso si la pregunta contiene el tópico indicado."
	^topicos anySatisfy: [ :esteTopico | esteTopico esElTopico: unTopico ]
]

{ #category : #'methods for tests' }
Pregunta >> titulo [
	"Retorna el título de la pregunta."
	^titulo
]

{ #category : #'methods for tests' }
Pregunta >> topicos [
	"Retorna la colección de tópicos."
	^topicos
]
