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

{ #category : #private }
CuOOraPerfilComponent >> noSeguirA: unUsuario [
	self session usuario dejarDeSeguirAlUsuario: unUsuario
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderCuerpoOn: aCanvas [
	self renderPerfilPreguntasOn: aCanvas.
	self renderPerfilBotonesOn: aCanvas.


]

{ #category : #rendering }
CuOOraPerfilComponent >> renderEncabezadoOn: aCanvas [
	aCanvas heading level: 1; with: 'CuOOra'.
	aCanvas heading level: 2; with: self session usuario nombre.
	aCanvas anchor callback: [ self logOut ]; with: 'Log out'.
	aCanvas horizontalRule.
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilBotonesOn: aCanvas [
	aCanvas form: [ 
		aCanvas submitButton callback: [ self answer. ]; with: 'Volver'.
	].
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilPreguntasListaOn: aCanvas [
	|preguntas|
	preguntas := usuario preguntasPorFechaDescendente.
	aCanvas unorderedList: [ 
		preguntas do: [ :unaPregunta | 
			aCanvas listItem: [ 
				self renderPreguntaRelevante: unaPregunta tituloOn: aCanvas. "self renderPregunta: unaPregunta tituloOn: aCanvas."
				self renderPregunta: unaPregunta topicosOn: aCanvas.
				(unaPregunta usuario = self session usuario)
				ifTrue: [ self renderPregunta: unaPregunta noLinkInfoOn: aCanvas. ]
				ifFalse: [ self renderPregunta: unaPregunta infoOn: aCanvas. ].
				self renderPost: unaPregunta creadaOn: aCanvas.
				self renderPost: unaPregunta votosOn: aCanvas.
				(unaPregunta usuario = self session usuario) ifTrue: [ self renderBorrarPost: unaPregunta on: aCanvas. ].
			].
			(preguntas last = unaPregunta) ifFalse: [ aCanvas horizontalRule. ].
		].
	].
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilPreguntasOn: aCanvas [
	self renderPerfilPreguntasTituloOn: aCanvas.
	self renderPerfilPreguntasListaOn: aCanvas.
	aCanvas horizontalRule.
	
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilPreguntasTituloOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas heading level: 1; with: [ aCanvas text: 'Preguntas de ', usuario nombre, ':'. ].
		(usuario = self session usuario)
		ifFalse: [
			aCanvas form: [
				(self session usuario esUsuarioSeguido: usuario)
				ifTrue: [ aCanvas submitButton callback: [ self noSeguirA: usuario ]; with: 'Dejar de seguir a ', usuario nombre. ]
				ifFalse: [ aCanvas submitButton callback: [ self seguirA: usuario. ]; with: 'Seguir a ', usuario nombre. ].
			].
		].
	].
]

{ #category : #private }
CuOOraPerfilComponent >> seguirA: unUsuario [
	self session usuario agregarUsuarioParaSeguir: unUsuario
]
