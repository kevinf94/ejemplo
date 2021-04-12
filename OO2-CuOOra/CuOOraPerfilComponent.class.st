"
.
"
Class {
	#name : #CuOOraPerfilComponent,
	#superclass : #CuOOrLayoutComponent,
	#instVars : [
		'usuario',
		'oldMisTopicos',
		'misTopicos',
		'topicosDelSistema'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #'instance creation' }
CuOOraPerfilComponent class >> conUsuario: unUsuario [
	^self new conUsuario: unUsuario; yourself.
]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> agregarElTopico: unTopico [
	(misTopicos includes: unTopico) ifFalse: [ ^misTopicos add: unTopico. ].
	^nil.
]

{ #category : #'instance creation' }
CuOOraPerfilComponent >> conUsuario: unUsuario [
	usuario := unUsuario
]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> dejarDeSeguirAlUsuario: unUsuario [
	(self session usuario dejarDeSeguirAlUsuario: unUsuario)
	ifNil: [ "mostrar mensaje de error no se pudo dejar de seguir al usuario" ]
]

{ #category : #private }
CuOOraPerfilComponent >> esMiPerfil [
	^(usuario = self session usuario)
]

{ #category : #initializing }
CuOOraPerfilComponent >> initialize [
	super initialize.
	topicosDelSistema := OrderedCollection new.
	topicosDelSistema addAll: (self model topicos asSortedCollection: [ :a :b | a nombre < b nombre. ]).
	misTopicos := OrderedCollection new.
	misTopicos addAll: (self session usuario topicos).
	oldMisTopicos := OrderedCollection new.
	oldMisTopicos addAll: misTopicos.

]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> perfilActualizarUsuario: unUsuario esSeguido: boolean [
	boolean ifFalse: [ 
		self dejarDeSeguirAlUsuario: unUsuario.
	].
]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> perfilGuardarTopicosDeInteres [
	misTopicos do: [ :unTopico | 
		(oldMisTopicos includes: unTopico)
		ifFalse: [ self session usuario agregarTopicoDeInteres: unTopico. ]
	].

]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> quitarElTopico: unTopico [
	(misTopicos includes: unTopico) ifTrue: [ ^misTopicos remove: unTopico. ].
	^nil.
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderCuerpoOn: aCanvas [
	self renderPerfilTituloOn: aCanvas.
	self renderPerfilPreguntasOn: aCanvas.

	"esto no se pidió en el enunciado"
	self esMiPerfil ifTrue: [
		aCanvas horizontalRule. self renderPerfilTopicosDeInteresOn: aCanvas.
		aCanvas horizontalRule. self renderPerfilUsuariosSeguidosOn: aCanvas.
	].

	aCanvas horizontalRule.
	self renderPerfilBotonVolerOn: aCanvas

]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> renderPerfilAgregarNuevosTopicosOn: aCanvas [
	aCanvas form: [ 
		aCanvas paragraph: [ 
			aCanvas label: [ aCanvas strong: 'Agregar el tópico: ' ].
			aCanvas select
				list: (topicosDelSistema);
				beOptional;
				optionalLabel: '-Seleccione un tópico-';
				callback: [ :topicoSeleccionado | topicoSeleccionado ifNotNil: [ misTopicos add: topicoSeleccionado. ]. ].
			aCanvas submitButton callback: [  ]; value: ' + '.
		].
	].
]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> renderPerfilBotonNoSeguirOn: aCanvas [
	aCanvas submitButton
		callback: [ self dejarDeSeguirAlUsuario: usuario; yourself. ];
		with: 'Dejar de seguir a ', usuario nombre.
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilBotonSeguirOn: aCanvas [
	aCanvas submitButton
		callback: [ self seguirA: usuario; yourself. ];
		with: 'Comenzar a seguir a ' , usuario nombre.
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilBotonVolerOn: aCanvas [
	aCanvas form: [ 
		aCanvas submitButton callback: [ self answer. ]; with: 'Volver'.
	].
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilPreguntasOn: aCanvas [
	|preguntas|
	preguntas := self model preguntasDelUsuario: usuario.
	
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
]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> renderPerfilQuitarTopicosOn: aCanvas [
	aCanvas form: [ 
		misTopicos do: [ :unTopico |
			aCanvas paragraph: [ 
				aCanvas checkbox
					value: true; onTrue: [ self agregarElTopico: unTopico. ] onFalse: [ self quitarElTopico: unTopico. ].
				aCanvas text: unTopico.
			].
		].
		aCanvas submitButton
			callback: [ self perfilGuardarTopicosDeInteres. ];
			with: 'Guardar cambios en tópicos de interés.'.
	].

]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilTituloContenido [
	(self esMiPerfil) ifTrue: [ ^'Mis preguntas:'. ].
	^'Preguntas de ', usuario nombre, ':'.

]

{ #category : #rendering }
CuOOraPerfilComponent >> renderPerfilTituloOn: aCanvas [
	aCanvas paragraph: [
		aCanvas heading level: 1; with: [ aCanvas text: (self renderPerfilTituloContenido). ].
		(self esMiPerfil) ifFalse: [
			aCanvas form: [ 
				(self session usuario esUsuarioSeguido: usuario)
				ifTrue: [ self renderPerfilBotonNoSeguirOn: aCanvas. ]
				ifFalse: [ self renderPerfilBotonSeguirOn: aCanvas. ].
			].
		].
	].
]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> renderPerfilTopicosDeInteresOn: aCanvas [
	
	aCanvas heading level: 1; with: 'Mis tópicos de interés:'.

	self renderPerfilAgregarNuevosTopicosOn: aCanvas.	
	self renderPerfilQuitarTopicosOn: aCanvas.
	

]

{ #category : #'methods for tests' }
CuOOraPerfilComponent >> renderPerfilUsuariosSeguidosOn: aCanvas [
	aCanvas paragraph: [
		aCanvas heading level: 1; with: [ aCanvas text: 'Mis usuarios seguidos:'. ].
		aCanvas form: [ 
			self session usuario usuariosSeguidos do: [ :unUsuario |
				aCanvas paragraph: [ 
					aCanvas checkbox value: true; callback: [ :value | self perfilActualizarUsuario: unUsuario esSeguido: value ].
					aCanvas text: unUsuario nombre.
				].
			].
			aCanvas submitButton callback: [  ]; with: 'Guardar cambios en usuarios seguidos.'
		].
	].

]

{ #category : #private }
CuOOraPerfilComponent >> seguirA: unUsuario [
	self session usuario agregarUsuarioParaSeguir: unUsuario
]
