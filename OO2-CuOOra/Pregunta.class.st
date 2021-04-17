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
Pregunta >> borrate [
	respuestas do: [ :unaRespuesta | unaRespuesta borrate ].
	topicos do: [ :unTopico | unTopico borrarLaPregunta: self ].
	usuario borrarLaPregunta: self.
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

	unUsuario agregarPregunta: self.
	unosTopicos do: [ :unTopico | unTopico agregarPregunta: self ].
]

{ #category : #accessing }
Pregunta >> crearRespuestaConTexto: unTexto usuario: unUsuario [
	^unUsuario agregarRespuesta: (respuestas add: (Respuesta conTexto: unTexto usuario: unUsuario)).
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
	respuestas := Set new.
	topicos := Set new.
]

{ #category : #accessing }
Pregunta >> respuestas [
	"Retorna la colección de respuestas de la pregunta, ordenadas por puntaje."
	^respuestas asSortedCollection: [ :a :b | a puntaje > b puntaje. ]
]

{ #category : #'methods for tests' }
Pregunta >> tenesLaRespuesta: unaRespuesta [
	"Retorna verdadero/falso si la pregunta contiene la respuesta indicada."
	^respuestas includes: unaRespuesta
]

{ #category : #accessing }
Pregunta >> tieneElTopico: unTopico [
	"Retorna verdadero/falso si la pregunta contiene el tópico indicado."
	"estaría de más???? <---------------------------------------------------------------------------------"
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
