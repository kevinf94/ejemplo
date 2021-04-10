"
.
"
Class {
	#name : #CuOOraPerfilComponent,
	#superclass : #CuOOrLayoutComponent,
	#instVars : [
		'usuario'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #'instance creation' }
CuOOraPerfilComponent class >> conUsuario: unUsuario [
	^self new conUsuario: unUsuario; yourself.
]

{ #category : #'instance creation' }
CuOOraPerfilComponent >> conUsuario: unUsuario [
	usuario := unUsuario
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderCuerpoOn: aCanvas [
	|preguntas|
	preguntas := self model preguntasDelUsuario: usuario.
	
	aCanvas paragraph: [ 
		aCanvas heading level: 1; with: [ 
			aCanvas text: 'Preguntas de ', usuario nombre, ':'.
		].
		(usuario = self session usuario)
		ifFalse: [ aCanvas form: [ aCanvas submitButton callback: [ self seguirA: usuario. ]; with: 'Seguir a ', usuario nombre. ]. ].
	].

	aCanvas unorderedList: [ 
		preguntas do: [ :unaPregunta | 
			aCanvas listItem: [ 
				self renderPreguntaRelevante: unaPregunta tituloOn: aCanvas. "self renderPregunta: unaPregunta tituloOn: aCanvas."
				self renderPregunta: unaPregunta topicosOn: aCanvas.
				self renderPregunta: unaPregunta noLinkInfoOn: aCanvas. "self renderPregunta: unaPregunta infoOn: aCanvas."
				self renderPost: unaPregunta votosOn: aCanvas.
				(unaPregunta usuario = self session usuario) ifTrue: [ self renderBorrarPost: unaPregunta on: aCanvas. ].
			].
			(preguntas last = unaPregunta) ifFalse: [ aCanvas horizontalRule. ].
		].
	].
	
	aCanvas horizontalRule.
	aCanvas form: [ 
		aCanvas submitButton callback: [ self answer. ]; with: 'Volver'.
		aCanvas space: 10.
		(usuario = self session usuario)
		ifFalse: [ aCanvas submitButton callback: [  ]; with: 'Dejar de seguir (?)'. ].
	].

]

{ #category : #private }
CuOOraPerfilComponent >> seguirA: unUsuario [
	self session usuario agregarUsuarioParaSeguir: unUsuario
]
