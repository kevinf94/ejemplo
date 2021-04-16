"
.
"
Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion',
		'preguntas'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creating }
Topico class >> conNombre: unNombreString descripcion: unaDescripcionString [
	^self new conNombre: unNombreString descripcion: unaDescripcionString
]

{ #category : #accessing }
Topico >> agregarPregunta: unaPregunta [
	^preguntas add: unaPregunta 
]

{ #category : #accessing }
Topico >> borrarLaPregunta: unaPregunta [
	^preguntas remove: unaPregunta ifAbsent: [ ^nil ].
]

{ #category : #creating }
Topico >> conNombre: unNombreString descripcion: unaDescripcionString [
	"Constructor."
	nombre := unNombreString.
	descripcion := unaDescripcionString.
]

{ #category : #'methods for tests' }
Topico >> descripcion [
	"Retorna la descripción del tópico."
	^ descripcion
]

{ #category : #accessing }
Topico >> esElTopico: unTopico [
	"Retorna verdadero/falso si el tópico (self) es el tópico (parámetro) indicado."
	^self = unTopico
]

{ #category : #initialization }
Topico >> initialize [
	preguntas := Set new.
]

{ #category : #'methods for tests' }
Topico >> nombre [
	"Retorna el nombre del tópico."
	^ nombre
]

{ #category : #accessing }
Topico >> preguntas [
	^preguntas
]

{ #category : #accessing }
Topico >> printOn: aStream [
	"Similar al 'toString()' de java. Al ver el contenido de una colección de objetos de
	tipo tópicos, se reemplaza el texto 'a Topic' por el 'nombre' del tópico."
	aStream nextPutAll: nombre
]
