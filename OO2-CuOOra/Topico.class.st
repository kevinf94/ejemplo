"
.
"
Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creating }
Topico class >> conNombre: unNombreString descripcion: unaDescripcionString [
	^self new conNombre: unNombreString descripcion: unaDescripcionString
]

{ #category : #creating }
Topico >> conNombre: unNombreString descripcion: unaDescripcionString [
	nombre := unNombreString.
	descripcion := unaDescripcionString.
]

{ #category : #'methods for tests' }
Topico >> descripcion [
	^ descripcion
]

{ #category : #accessing }
Topico >> esElTopico: unTopico [
	^self = unTopico
]

{ #category : #'methods for tests' }
Topico >> nombre [
	^ nombre
]

{ #category : #accessing }
Topico >> printOn: aStream [
	aStream nextPutAll: nombre
]
