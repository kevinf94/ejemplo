"
.
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'votos',
		'fechaHoraCreacion'
	],
	#category : #'OO2-CuOOra-ModeloDeDominio'
}

{ #category : #accessing }
Post >> agregarDislikeDelUsuario: unUsuario [
	|elVoto|
	elVoto := self buscarVotoDelUsuario: unUsuario.
	elVoto ifNil: [ votos add: (Voto dislikeDelUsuario: unUsuario). ^self. ].
	elVoto esLike ifTrue: [ elVoto cambiar ]
]

{ #category : #accessing }
Post >> agregarLikeDelUsuario: unUsuario [
	|elVoto|
	elVoto := self buscarVotoDelUsuario: unUsuario.
	elVoto ifNil: [ votos add: (Voto likeDelUsuario: unUsuario). ^self. ].
	elVoto esDislike ifTrue: [ elVoto cambiar ]
]

{ #category : #internal }
Post >> buscarVotoDelUsuario: unUsuario [
	^votos detect: [ :unVoto | unVoto esDelUsuario: unUsuario ] ifNone: [ ^nil ]
]

{ #category : #accessing }
Post >> cantidadDeDislikes [
	^self dislikes size
]

{ #category : #accessing }
Post >> cantidadDeLikes [
	^self likes size
]

{ #category : #'methods for tests' }
Post >> creacion [
	^fechaHoraCreacion
]

{ #category : #internal }
Post >> dislikes [
	^votos select: [ :unVoto | unVoto esDislike ]
]

{ #category : #accessing }
Post >> esDelUsuario: unUsuario [
	^usuario = unUsuario
]

{ #category : #initializing }
Post >> initialize [
	fechaHoraCreacion := DateAndTime now.
	votos := OrderedCollection new.
]

{ #category : #internal }
Post >> likes [
	^votos select: [ :unVoto | unVoto esLike ]
]

{ #category : #accessing }
Post >> puntaje [
	^(self likes size) - (self dislikes size)
]

{ #category : #accessing }
Post >> quitarDislikeDelUsuario: unUsuario [
	votos remove: (self dislikes detect: [ :unVoto | unVoto esDelUsuario: unUsuario ])
	
]

{ #category : #accessing }
Post >> quitarLikeDelUsuario: unUsuario [
	votos remove: (self likes detect: [ :unVoto | unVoto esDelUsuario: unUsuario ])
	
]

{ #category : #accessing }
Post >> tieneDislikeDelUsuario: unUsuario [
	|voto|
	voto := (self buscarVotoDelUsuario: unUsuario).
	voto ifNil: [ ^false. ].
	^voto esDislike
]

{ #category : #accessing }
Post >> tieneLikeDelUsuario: unUsuario [
	|voto|
	voto := (self buscarVotoDelUsuario: unUsuario).
	voto ifNil: [ ^false. ].
	^voto esLike
]

{ #category : #'methods for tests' }
Post >> usuario [
	^usuario
]

{ #category : #'methods for tests' }
Post >> votos [
	^votos
]
