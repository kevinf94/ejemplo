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
	"Agrega un 'dislike' de un usuario a los votos del post. Si no tiene votos del usuario, lo crea.
	Si yatenía 'like' de éste, lo cambia a 'dislike'."
	|elVoto|
	elVoto := self buscarVotoDelUsuario: unUsuario.
	elVoto ifNil: [ votos add: (Voto dislikeDelUsuario: unUsuario). ^self. ].
	"En una creación de mas tipos de votos, la siguiente línea de código no sirve.
	¿Debería eliminar el voto actual y crear el que corresponde?
		votos remove: elVoto.
		votos add: (Voto tipoDelUsuario: unUsuario).
	Ocurre lo mismo en el método #agregarLikeDelUsuario."
	elVoto esLike ifTrue: [ elVoto cambiar ]
]

{ #category : #accessing }
Post >> agregarLikeDelUsuario: unUsuario [
	"Agrega un 'like' de un usuario a los votos del post. Si no tiene votos del usuario, lo crea.
	Si yatenía 'dislike' de éste, lo cambia a 'like'."
	|elVoto|
	elVoto := self buscarVotoDelUsuario: unUsuario.
	elVoto ifNil: [ votos add: (Voto likeDelUsuario: unUsuario). ^self. ].
	elVoto esDislike ifTrue: [ elVoto cambiar ]
]

{ #category : #accessing }
Post >> borrate [
	self subclassResponsibility
]

{ #category : #internal }
Post >> buscarVotoDelUsuario: unUsuario [
	"Busca el voto de un usuario determinado y lo retorna, si no existe, retorna el valor nil."
	^votos detect: [ :unVoto | unVoto esDelUsuario: unUsuario ] ifNone: [ ^nil ]
]

{ #category : #accessing }
Post >> cantidadDeDislikes [
	"Retonrna la cantidad de dislikes que tiene el post."
	^self dislikes size
]

{ #category : #accessing }
Post >> cantidadDeLikes [
	"Retorna la cantida de likes que tiene el post."
	^self likes size
]

{ #category : #internal }
Post >> dislikes [
	"Retorna una colección con todos los votos de tipo 'dislike' del post."
	^votos select: [ :unVoto | unVoto esDislike ]
]

{ #category : #accessing }
Post >> esDelUsuario: unUsuario [
	"Retorna verdadero/falso si un post fue realizado por un usuario determinado."
	^usuario = unUsuario
]

{ #category : #'methods for tests' }
Post >> fechaYHoraDeCreacion [
	"Retorna la fecha de creación del post."
	^fechaHoraCreacion
]

{ #category : #'methods for tests' }
Post >> fechaYHoraDeCreacion: aDateAndTime [
	fechaHoraCreacion := aDateAndTime
]

{ #category : #initializing }
Post >> initialize [
	fechaHoraCreacion := DateAndTime now.
	votos := Set new.
]

{ #category : #internal }
Post >> likes [
	"Retorna una colección con todos los votos de tipo 'like' del post."
	^votos select: [ :unVoto | unVoto esLike ]
]

{ #category : #accessing }
Post >> puntaje [
	"Retorna el puntaje del post. El cual se calcula con el total de 'likes' menos el totoal de 'dislikes'."
	^(self likes size) - (self dislikes size)
]

{ #category : #accessing }
Post >> quitarDislikeDelUsuario: unUsuario [
	"Elimina el voto 'dislike' de un usuario determinado y lo retorna. De no existir el voto, retorna nil."
	^votos remove: (self dislikes detect: [ :unVoto | unVoto esDelUsuario: unUsuario ]) ifAbsent: [ ^nil ]
	
]

{ #category : #accessing }
Post >> quitarLikeDelUsuario: unUsuario [
	"Elimina el voto 'like' de un usuario determinado y lo retorna. De no existir el voto, retorna nil."
	votos remove: (self likes detect: [ :unVoto | unVoto esDelUsuario: unUsuario ])
	
]

{ #category : #accessing }
Post >> tieneDislikeDelUsuario: unUsuario [
	"Retorna verdadero si el post tiene un voto de tipo 'dislike' del usuario determinado.'
	De lo contrario, retorna falso."
	|voto|
	voto := (self buscarVotoDelUsuario: unUsuario).
	voto ifNil: [ ^false. ].	
	^voto esDislike
	
	"Debería ser asi el código de este método???
	votos detect: [ :unVoto | unVoto esDelUsuario: unUsuario ] ifFound: [ :unVoto | ^(unVoto esDislike) ] ifNone: [ ^false ]."
	

]

{ #category : #accessing }
Post >> tieneLikeDelUsuario: unUsuario [
	"Retorna verdadero si el post tiene un voto de tipo 'like' del usuario determinado.'
	De lo contrario, retorna falso."

	|voto|
	voto := (self buscarVotoDelUsuario: unUsuario).
	voto ifNil: [ ^false. ].
	^voto esLike

	"Debería ser asi el código de este método???
	votos detect: [ :unVoto | unVoto esDelUsuario: unUsuario ] ifFound: [ :unVoto | ^(unVoto esLike) ] ifNone: [ ^false ]."
]

{ #category : #'methods for tests' }
Post >> usuario [
	"Retorna el usuaio que creo el post."
	^usuario
]

{ #category : #'methods for tests' }
Post >> votos [
	"Retorna la colección de votos."
	^votos
]
