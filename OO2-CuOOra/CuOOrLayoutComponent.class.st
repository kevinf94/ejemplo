"
.
"
Class {
	#name : #CuOOrLayoutComponent,
	#superclass : #WAComponent,
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #actions }
CuOOrLayoutComponent >> borrarPost: unaPost [
	unaPost borrate
]

{ #category : #callbacks }
CuOOrLayoutComponent >> buttonDislike: unPost [
	((self textoBotonDislikeParaElPost: unPost) match: 'Dar Dislike')
	ifTrue: [ unPost agregarDislikeDelUsuario: (self session usuario). ]
	ifFalse: [ unPost quitarDislikeDelUsuario: (self session usuario). ].
]

{ #category : #callbacks }
CuOOrLayoutComponent >> buttonLike: unPost [
	((self textoBotonLikeParaElPost: unPost) match: 'Dar Like')
	ifTrue: [ unPost agregarLikeDelUsuario: (self session usuario) ]
	ifFalse: [ unPost quitarLikeDelUsuario: (self session usuario) ].
]

{ #category : #private }
CuOOrLayoutComponent >> fechaConNombre: aDateAndTime [
	^(aDateAndTime dayOfWeekName) ,' ', (aDateAndTime dayOfMonth)asString, ', ', (aDateAndTime monthName), ' ', (aDateAndTime year)asString,'.'.

	"Armar diccionario"
	"|nombreDelDia nombreDelMes|
	nombreDelDia := aDateAndTime dayOfWeekName.
	nombreDelMes := aDateAndTime monthName.
	
	((nombreDelDia asLowercase) match: ('Sunday' asLowercase)) ifTrue: [ nombreDelDia := 'Domingo' ].
	((nombreDelDia asLowercase) match: ('Monday' asLowercase)) ifTrue: [ nombreDelDia := 'Lunes' ].
	((nombreDelDia asLowercase) match: ('Tuesday' asLowercase)) ifTrue: [ nombreDelDia := 'Martes' ].
	((nombreDelDia asLowercase) match: ('Wednesday' asLowercase)) ifTrue: [ nombreDelDia := 'Miercoles' ].
	((nombreDelDia asLowercase) match: ('Thursday' asLowercase)) ifTrue: [ nombreDelDia := 'Jueves' ].
	((nombreDelDia asLowercase) match: ('Friday' asLowercase)) ifTrue: [ nombreDelDia := 'Viernes' ].
	((nombreDelDia asLowercase) match: ('Saturday' asLowercase)) ifTrue: [ nombreDelDia := 'Sabado' ].

	
	((nombreDelMes asLowercase) match: ('January' asLowercase)) ifTrue: [ nombreDelMes := 'Enero' ].
	((nombreDelMes asLowercase) match: ('February' asLowercase)) ifTrue: [ nombreDelMes := 'Febrero' ].
	((nombreDelMes asLowercase) match: ('March' asLowercase)) ifTrue: [ nombreDelMes := 'Marzo' ].
	((nombreDelMes asLowercase) match: ('April' asLowercase)) ifTrue: [ nombreDelMes := 'Abril' ].
	((nombreDelMes asLowercase) match: ('May' asLowercase)) ifTrue: [ nombreDelMes := 'Mayo' ].
	((nombreDelMes asLowercase) match: ('June' asLowercase)) ifTrue: [ nombreDelMes := 'Junio' ].
	((nombreDelMes asLowercase) match: ('July' asLowercase)) ifTrue: [ nombreDelMes := 'Julio' ].
	((nombreDelMes asLowercase) match: ('August' asLowercase)) ifTrue: [ nombreDelMes := 'Agosto' ].
	((nombreDelMes asLowercase) match: ('September' asLowercase)) ifTrue: [ nombreDelMes := 'Septiembre' ].
	((nombreDelMes asLowercase) match: ('October' asLowercase)) ifTrue: [ nombreDelMes := 'Octubre' ].
	((nombreDelMes asLowercase) match: ('November' asLowercase)) ifTrue: [ nombreDelMes := 'Noviembre' ].
	((nombreDelMes asLowercase) match: ('December' asLowercase)) ifTrue: [ nombreDelMes := 'Diciembre' ].
	
	^nombreDelDia,' ', (aDateAndTime dayOfMonth)asString, ', ', nombreDelMes, ' ', (aDateAndTime year)asString,'.'."
]

{ #category : #initializing }
CuOOrLayoutComponent >> initialize [
	super initialize
]

{ #category : #callbacks }
CuOOrLayoutComponent >> logOut [
    self session unregister. 
    self requestContext redirectTo: self application url
	
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderBorrarPost: unPost on: aCanvas [
	aCanvas form: [ 
		aCanvas submitButton callback: [ self borrarPost: unPost. ]; value: ' Eliminar '.
	].
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderContentOn: aCanvas [
	self renderEncabezadoOn: aCanvas.
	self renderCuerpoOn: aCanvas
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderCuerpoOn: aCanvas [
	self subclassResponsibility
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderEncabezadoOn: aCanvas [
	aCanvas heading level: 1; with: 'CuOOra'.
	aCanvas heading level: 2; with: [ self renderLinkAlPerfilDelUsuario: nil On: aCanvas; yourself. ].
	aCanvas anchor callback: [ self logOut ]; with: 'Log out'.
	aCanvas horizontalRule.
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderLinkAlPerfilDelUsuario: unUsuario On: aCanvas [
	|elUsuario|
	elUsuario := unUsuario.
	elUsuario ifNil: [ elUsuario := self session usuario. ].
	aCanvas anchor callback: [ self call: (CuOOraPerfilComponent conUsuario: elUsuario); yourself. ]; with: elUsuario nombre.
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPost: unPost creadaOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas text: 'Creada: ', (self fechaConNombre: (unPost fechaYHoraDeCreacion)).
		
	].
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPost: unPost votosOn: aCanvas [
	aCanvas paragraph: [
		aCanvas form: [ 
			aCanvas text: unPost cantidadDeLikes; text: ' likes. | '.
			aCanvas submitButton callback: [ self buttonLike: unPost. ]; with: (self textoBotonLikeParaElPost: unPost).
			aCanvas text: ' | '; text: unPost cantidadDeDislikes; text: ' dislikes. | '.
			aCanvas submitButton callback: [ self buttonDislike: unPost. ]; with: (self textoBotonDislikeParaElPost: unPost).
		]
	]
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPregunta: unaPregunta infoOn: aCanvas [
	aCanvas paragraph: [
		aCanvas
			text: 'Realizada por '; strong: [ self renderLinkAlPerfilDelUsuario: (unaPregunta usuario) On: aCanvas. ];
			text: '. | ';
			text: unaPregunta cantidadDeRespuestas; text: ' respuestas.'.
	].

]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPregunta: unaPregunta noLinkInfoOn: aCanvas [
	aCanvas paragraph: [
		aCanvas
			text: 'Realizada por '; strong: unaPregunta usuario nombre;
			text: '. | ';
			text: unaPregunta cantidadDeRespuestas; text: ' respuestas.'.
	].

]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPregunta: unaPregunta tituloOn: aCanvas [
	aCanvas paragraph: [
		aCanvas emphasis: [ aCanvas strong: [ aCanvas big: unaPregunta titulo ]. ].
	].
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPregunta: unaPregunta topicosOn: aCanvas [
	aCanvas paragraph: [
		aCanvas text: 'Tópicos: '; emphasis: [ 
			unaPregunta topicos do: [ :unTopico | 
				aCanvas text: (unTopico nombre).
				(unaPregunta topicos last = unTopico) ifTrue: [ aCanvas text: '.' ] ifFalse: [ aCanvas text: ', '. ].
			].
		].
	].
]

{ #category : #rendering }
CuOOrLayoutComponent >> renderPreguntaRelevante: unaPregunta tituloOn: aCanvas [
	aCanvas paragraph: [
		aCanvas anchor
			callback: [ self call: (CuOOraDetallePreguntaComponent conPregunta: unaPregunta); yourself. ];
			with: [ aCanvas emphasis: [ aCanvas strong: [ aCanvas big: unaPregunta titulo ]. ]. ].
	].


]

{ #category : #private }
CuOOrLayoutComponent >> textoBotonDislikeParaElPost: unPost [
	(unPost tieneDislikeDelUsuario: self session usuario)
	ifTrue: [ ^'Quitar Dislike' ].
	^'Dar Dislike'.
]

{ #category : #private }
CuOOrLayoutComponent >> textoBotonLikeParaElPost: unPost [
	(unPost tieneLikeDelUsuario: self session usuario)
	ifTrue: [ ^'Quitar Like' ].
	^'Dar Like'.
]
