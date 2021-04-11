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
	fechaHoraCreacion := DateAndTime now.
	(self esLike) ifTrue: [ tipo := 'dislike'. ^self. ].
	tipo := 'like'.
]

{ #category : #private }
Voto >> conUsuario: unUsuario tipo: unTipo [
	usuario := unUsuario.
	tipo := unTipo.

]

{ #category : #accessing }
Voto >> esDelUsuario: unUsuario [
	^usuario = unUsuario
]

{ #category : #accessing }
Voto >> esDislike [
	^tipo = 'dislike'
]

{ #category : #accessing }
Voto >> esLike [
	^tipo = 'like'
]

{ #category : #initializing }
Voto >> initialize [
	fechaHoraCreacion := DateAndTime now.
]
