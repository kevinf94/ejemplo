"
.
"
Class {
	#name : #CuOOraDetallePreguntaComponent,
	#superclass : #CuOOrLayoutComponent,
	#instVars : [
		'pregunta'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #'instance creation' }
CuOOraDetallePreguntaComponent class >> conPregunta: unaPregutna [
	^self new conPregunta: unaPregutna; yourself.
]

{ #category : #'instance creation' }
CuOOraDetallePreguntaComponent >> conPregunta: unaPregunta [
	pregunta := unaPregunta
]

{ #category : #private }
CuOOraDetallePreguntaComponent >> redactarRespuesta [
	self call: (CuOOraEditorRespuestaComponent conPregunta: pregunta).
]

{ #category : #rendering }
CuOOraDetallePreguntaComponent >> renderCrearRespuestaOn: aCanvas [
	aCanvas form: [ 
		aCanvas paragraph: [ 
			aCanvas anchor callback: [ self redactarRespuesta. ]; with: [ aCanvas image url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf9jPYKPTSaQnhhl0R6gfhH9g-d3pIZIZ1HSqjo1aruKHqbZKQ9zg1IlzFIAU5nmw_JFk&usqp=CAU' ].
			aCanvas space: 2.
			aCanvas submitButton callback: [ self volver ]; with: 'Vovler'.
		].
	].	
]

{ #category : #rendering }
CuOOraDetallePreguntaComponent >> renderCuerpoOn: aCanvas [
	self renderPreguntaOn: aCanvas.
	self renderRespuestasOn: aCanvas.
	self renderCrearRespuestaOn: aCanvas.


]

{ #category : #rendering }
CuOOraDetallePreguntaComponent >> renderPreguntaOn: aCanvas [
	self renderPregunta: pregunta tituloOn: aCanvas.
	self renderPregunta: pregunta topicosOn: aCanvas.
	self renderPregunta: pregunta infoOn: aCanvas.
	self renderPost: pregunta votosOn: aCanvas.
	aCanvas horizontalRule.

]

{ #category : #rendering }
CuOOraDetallePreguntaComponent >> renderRespuestaInfo: unaRespuesta on: aCanvas [
	aCanvas paragraph: [ 
		aCanvas emphasis: [ 
			aCanvas strong: [ 
				aCanvas big with: [ 
					aCanvas text: 'Respuesta de '." text: (unaRespuesta usuario nombre)."
					self renderLinkAlPerfilDelUsuario: (unaRespuesta usuario) On: aCanvas.
				].
			].
		].
	].
]

{ #category : #rendering }
CuOOraDetallePreguntaComponent >> renderRespuestaTexto: unaRespuesta on: aCanvas [
	aCanvas paragraph: [ aCanvas text: unaRespuesta texto. ].
]

{ #category : #rendering }
CuOOraDetallePreguntaComponent >> renderRespuestasOn: aCanvas [
	(pregunta respuestas) ifEmpty: [ aCanvas paragraph; strong: 'No hay respuestas.'. ^self. ].
	aCanvas unorderedList: [ 
		pregunta respuestas do: [ :unaRespuesta |
			aCanvas listItem: [ 
				self renderRespuestaInfo: unaRespuesta on: aCanvas.
				self renderRespuestaTexto: unaRespuesta on: aCanvas.
				self renderPost: unaRespuesta votosOn: aCanvas.
			].
		].
	].
	aCanvas horizontalRule.
	aCanvas paragraph: 'No hay mas respuestas.'
]

{ #category : #callbacks }
CuOOraDetallePreguntaComponent >> volver [
	pregunta := nil.
	self answer.
]
