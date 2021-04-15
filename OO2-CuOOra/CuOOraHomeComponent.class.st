"
|miAplicacion|
CuOOra clearSoleInstance.
WAAdmin unregister: 'cuoora'.
miAplicacion := WAAdmin register: CuOOraLoginComponent asApplicationAt: 'cuoora'.
miAplicacion sessionClass: CuOOraSessionWithUser.
"
Class {
	#name : #CuOOraHomeComponent,
	#superclass : #CuOOrLayoutComponent,
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #rendering }
CuOOraHomeComponent >> renderCrearPreguntaOn: aCanvas [

	aCanvas anchor callback: [ self call: CuOOraEditorPreguntaComponent new. ]; with: [ 
		aCanvas image url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN0cSqfiKx1OCF5bNrfEgCD2iMy51YXpeUuA&usqp=CAU'.
			"height: 64; width: 64."
	].
]

{ #category : #rendering }
CuOOraHomeComponent >> renderCuerpoOn: aCanvas [
	self renderPreguntasRelevantesOn: aCanvas.
	self renderCrearPreguntaOn: aCanvas.
	
]

{ #category : #rendering }
CuOOraHomeComponent >> renderPregunta: unaPregunta On: aCanvas [
	self renderPreguntaRelevante: unaPregunta tituloOn: aCanvas.
	self renderPregunta: unaPregunta topicosOn: aCanvas.
	self renderPregunta: unaPregunta infoOn: aCanvas.
	self renderPost: unaPregunta creadaOn: aCanvas.
	self renderPost: unaPregunta votosOn: aCanvas.
	self renderBorrarPost: unaPregunta on: aCanvas.
	
]

{ #category : #rendering }
CuOOraHomeComponent >> renderPreguntasRelevantesOn: aCanvas [
	|relevantes|
	relevantes := self session usuario preguntasRelevantes.
	
	aCanvas heading level: 1; with: 'Ultimas preguntas'.

	aCanvas unorderedList: [ 
		relevantes do: [ :unaPregunta | 
			aCanvas listItem: [ 
				self renderPregunta: unaPregunta On: aCanvas.
				(relevantes last = unaPregunta) ifFalse: [ aCanvas horizontalRule. ].
			].
		].
	].
	aCanvas horizontalRule.

]
