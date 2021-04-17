"
Posible extensión de funcionalidad:

conPregunta: unaPregunta yRespuesta: unaRespuesta
	^self new conPregunta: unaPregunta yRespuesta: unaRespuesta; yourself

conPregunta: unaPregunta yRespuesta: unaRespuesta
	pregunta := unaPregunta.
	respuesta := unaRespuesta.
	texto := unaRespuesta texto.
"
Class {
	#name : #CuOOraEditorRespuestaComponent,
	#superclass : #CuOOrLayoutComponent,
	#instVars : [
		'nuevoTexto',
		'pregunta',
		'texto'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #'instance creation' }
CuOOraEditorRespuestaComponent class >> conPregunta: unaPregunta [
	^self new conPregunta: unaPregunta; yourself.
]

{ #category : #callbacks }
CuOOraEditorRespuestaComponent >> cancelarRespuesta [
	self clearVariables.
	self answer.
]

{ #category : #private }
CuOOraEditorRespuestaComponent >> clearVariables [
	pregunta := nil.
	nuevoTexto := nil.
	"respuesta := nil."
	texto := nil.
]

{ #category : #'instance creation' }
CuOOraEditorRespuestaComponent >> conPregunta: unaPregunta [
	pregunta := unaPregunta.

]

{ #category : #callbacks }
CuOOraEditorRespuestaComponent >> publicarRespuesta [
	((texto isNil) or: [ texto isEmpty ])
	ifTrue: [ "self clearVariables." ^self ].
	
	"self model agregarRespuestaParaLaPregunta: pregunta texto: nuevoTexto usuario: self session usuario."
	pregunta crearRespuestaConTexto: texto usuario: self session usuario.
	self clearVariables.
	self answer.
]

{ #category : #rendering }
CuOOraEditorRespuestaComponent >> renderCrearRespuestaBotones: aCanvas [
	aCanvas form: [ 
		aCanvas paragraph: [ 
			aCanvas submitButton callback: [ self publicarRespuesta. ]; value: 'Publicar respuesta'.
			aCanvas space: 2.
			aCanvas submitButton callback: [ self cancelarRespuesta. ]; value: 'Cancelar y volver'.
		].
	].
]

{ #category : #rendering }
CuOOraEditorRespuestaComponent >> renderCuerpoOn: aCanvas [
	self renderPreguntaOn: aCanvas.
	aCanvas form: [ 
		self renderTextImputOn: aCanvas.
		self renderCrearRespuestaBotones: aCanvas.
	].
]

{ #category : #rendering }
CuOOraEditorRespuestaComponent >> renderPreguntaOn: aCanvas [
	self renderPregunta: pregunta tituloOn: aCanvas.
	self renderPregunta: pregunta topicosOn: aCanvas.
	self renderPregunta: pregunta infoOn: aCanvas.
	self renderPost: pregunta votosOn: aCanvas.
	aCanvas horizontalRule.
]

{ #category : #rendering }
CuOOraEditorRespuestaComponent >> renderTextImputOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas label: [ aCanvas strong: 'Respuesta:'. ].
		aCanvas paragraph.
		aCanvas textArea on: #texto of: self; columns: 40; rows: 4.
	].
]

{ #category : #accessing }
CuOOraEditorRespuestaComponent >> texto [
	^texto
]

{ #category : #accessing }
CuOOraEditorRespuestaComponent >> texto: unTexto [
	texto := unTexto.
]
