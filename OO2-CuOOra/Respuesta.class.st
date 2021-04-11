"
.
"
Class {
	#name : #Respuesta,
	#superclass : #Post,
	#instVars : [
		'texto'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creating }
Respuesta class >> conTexto: unTexto usuario: unUsuario [
	^self new conTexto: unTexto usuario: unUsuario
]

{ #category : #creating }
Respuesta >> conTexto: unTexto usuario: unUsuario [
	texto := unTexto.
	usuario := unUsuario.
]

{ #category : #'methods for tests' }
Respuesta >> texto [
	^texto
]
