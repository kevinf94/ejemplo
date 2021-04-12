"
.
"
Class {
	#name : #Voto,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'tipo',
		'fechaHoraCreacion'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #creating }
Voto class >> dislikeDelUsuario: unUsuario [
	^self new conUsuario: unUsuario tipo: 'dislike'
]

{ #category : #creating }
Voto class >> likeDelUsuario: unUsuario [
	^self new conUsuario: unUsuario tipo: 'like'
]

{ #category : #accessing }
Voto >> cambiar [
	"Intercambia el tipo de voto del voto, y actualiza la fecha y hora del cambio."
	"Este método solo sirve si los tipos de votos son solo dos."
	fechaHoraCreacion := DateAndTime now.
	(self esLike) ifTrue: [ tipo := 'dislike'. ^self. ].
	tipo := 'like'.
]

{ #category : #private }
Voto >> conUsuario: unUsuario tipo: unTipo [
	"Constructor."
	usuario := unUsuario.
	tipo := unTipo.

]

{ #category : #accessing }
Voto >> esDelUsuario: unUsuario [
	"Retorna verdadero/falso si el usuario indicado es el del voto."
	^usuario = unUsuario
]

{ #category : #accessing }
Voto >> esDislike [
	"Retorna verdadero/falso si el voto es del topi 'dislike'."
	^tipo = 'dislike'
]

{ #category : #accessing }
Voto >> esLike [
	"Retorna verdadero/falso si el voto es del topi 'like'."
	^tipo = 'like'
]

{ #category : #initializing }
Voto >> initialize [
	fechaHoraCreacion := DateAndTime now.
]
