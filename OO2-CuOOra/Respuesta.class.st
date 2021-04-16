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

{ #category : #accessing }
Respuesta >> borrate [
"No necesita test, ya es testeado en la clase usuario. Por que cuando la respuesta es contenida en la coleccion del usuario que la creo, la respuesta le manda el mensaje al usuario para que la borre "
	usuario borrarLaRespuesta: self
]

{ #category : #creating }
Respuesta >> conTexto: unTexto usuario: unUsuario [
	"Constructor."
	texto := unTexto.
	usuario := unUsuario.
	
	unUsuario agregarRespuesta: self.
	
]

{ #category : #'methods for tests' }
Respuesta >> texto [
	"Retorna el texto de la respuesta."
	^texto
]
