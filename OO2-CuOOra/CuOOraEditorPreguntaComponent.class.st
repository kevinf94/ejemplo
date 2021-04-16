"
.
"
Class {
	#name : #CuOOraEditorPreguntaComponent,
	#superclass : #CuOOrLayoutComponent,
	#instVars : [
		'cuooraSoleInstance',
		'pregunta',
		'nuevoTitulo',
		'nuevaDescripcion',
		'nuevosTopicos',
		'topicosDelSistema'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #'instance creation' }
CuOOraEditorPreguntaComponent class >> conPregunta: unaPregunta [
	^self new conPregunta: unaPregunta; yourself. 
]

{ #category : #callbacks }
CuOOraEditorPreguntaComponent >> agregarTopico: topicoSeleccionado [
	topicoSeleccionado ifNil: [ ^self. ].
	topicosDelSistema remove: topicoSeleccionado.
	nuevosTopicos add: topicoSeleccionado.
]

{ #category : #callbacks }
CuOOraEditorPreguntaComponent >> cancelarPregunta [
	self clearVariables.
	self answer.
]

{ #category : #private }
CuOOraEditorPreguntaComponent >> clearVariables [
	pregunta := nil.
	nuevosTopicos := OrderedCollection new.
	nuevoTitulo := nil.
	nuevaDescripcion := nil.
	topicosDelSistema := self topicosDelSistemaOrdenados.
]

{ #category : #'instance creation' }
CuOOraEditorPreguntaComponent >> conPregunta: unaPregunta [
	nuevoTitulo := unaPregunta titulo.
	nuevaDescripcion := unaPregunta descripcion.
	nuevosTopicos := unaPregunta topicos.
]

{ #category : #accessing }
CuOOraEditorPreguntaComponent >> descripcion [
	^nuevaDescripcion  
]

{ #category : #accessing }
CuOOraEditorPreguntaComponent >> descripcion: unaDescripcion [ 
	nuevaDescripcion := unaDescripcion 
]

{ #category : #initializing }
CuOOraEditorPreguntaComponent >> initialize [

	super initialize.
	cuooraSoleInstance := CuOOra soleInstance.
	topicosDelSistema := self topicosDelSistemaOrdenados.
	nuevosTopicos := OrderedCollection new.

]

{ #category : #callbacks }
CuOOraEditorPreguntaComponent >> logOut [
    self session unregister. 
    self requestContext redirectTo: self application url
]

{ #category : #callbacks }
CuOOraEditorPreguntaComponent >> publicarPregunta [
	((nuevosTopicos size < 1) or: [ (nuevoTitulo isNil) or: [ (nuevoTitulo isEmpty) or: [ (nuevaDescripcion isNil) or: [ (nuevaDescripcion isEmpty ) ] ] ] ] )
	ifTrue: [ "self clearVariables." ^self ].
	
	Pregunta conTopicos: nuevosTopicos titulo: nuevoTitulo descripcion: nuevaDescripcion usuario: (self session usuario).
	self clearVariables.
	self answer.
]

{ #category : #callbacks }
CuOOraEditorPreguntaComponent >> quitarElTopico: unTopico [
	nuevosTopicos remove: unTopico.
	topicosDelSistema add: unTopico.
]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderCrearPreguntaAgregarTopicosOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas label: [ aCanvas strong: 'Agregar el tópico: ' ].
		aCanvas select
			list: (topicosDelSistema);
			beOptional;
			optionalLabel: '-Seleccione un tópico-';
			callback: [ :topicoSeleccionado | self agregarTopico: topicoSeleccionado; yourself. ].
		aCanvas submitButton callback: [  ]; value: ' + '.
	].
]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderCrearPreguntaBotones: aCanvas [
	aCanvas paragraph: [ 
		aCanvas submitButton callback: [ self publicarPregunta. ]; value: 'Publicar pregunta'.
		aCanvas space: 2.
		aCanvas submitButton callback: [ self cancelarPregunta. ]; value: 'Cancelar y volver'.
	].
]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderCrearPreguntaDescripcionOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas label: [ aCanvas strong: 'Descripci.on:'. ].
		aCanvas paragraph.
		aCanvas textArea on: #descripcion of: self; columns: 40; rows: 4.
	].
]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderCrearPreguntaTituloOn: aCanvas [
	aCanvas paragraph: [
		aCanvas label: [ aCanvas strong: 'Título:' ].
		aCanvas space.
		aCanvas textInput on: #titulo of: self.
	].
]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderCrearPreguntaVerQuitarTopicosOn: aCanvas [
	(nuevosTopicos)
	ifEmpty: [ 
		aCanvas paragraph: [ aCanvas text: 'Debe seleccionar al menos un tópico, y puede agregar varios.' ].
		^self.
	].
	
	aCanvas paragraph: [ 
		aCanvas label: [ aCanvas strong: 'Quitar el tópico: '. ].
		nuevosTopicos do: [ :unTopico | 
			aCanvas anchor callback: [ self quitarElTopico: unTopico; yourself. ]; with: unTopico nombre. aCanvas space.
		].
	].
]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderCuerpoOn: aCanvas [
	
	aCanvas heading level: 2; with: 'Crear pregunta'.
	aCanvas horizontalRule.
	
	aCanvas form: [ 
		self renderCrearPreguntaTituloOn: aCanvas.
		self renderCrearPreguntaDescripcionOn: aCanvas.
		self renderCrearPreguntaVerQuitarTopicosOn: aCanvas.
		self renderCrearPreguntaAgregarTopicosOn: aCanvas.
		self renderCrearPreguntaBotones: aCanvas.
	]

]

{ #category : #rendering }
CuOOraEditorPreguntaComponent >> renderEncabezadoOn: aCanvas [
	aCanvas heading level: 1; with: 'CuOOra'.
	aCanvas heading level: 2; with: self session usuario nombre.
	aCanvas anchor callback: [ self logOut ]; with: 'Log out'.
	aCanvas horizontalRule.
]

{ #category : #accessing }
CuOOraEditorPreguntaComponent >> titulo [
	^nuevoTitulo
]

{ #category : #accessing }
CuOOraEditorPreguntaComponent >> titulo: unTitulo [
	nuevoTitulo := unTitulo 
]

{ #category : #accessing }
CuOOraEditorPreguntaComponent >> topicos [
	^nuevosTopicos
]

{ #category : #accessing }
CuOOraEditorPreguntaComponent >> topicos: unosTopicos [
	nuevosTopicos := unosTopicos
]

{ #category : #private }
CuOOraEditorPreguntaComponent >> topicosDelSistemaOrdenados [
	^(cuooraSoleInstance topicos) asSortedCollection: [ :a :b | a nombre < b nombre ]
]
