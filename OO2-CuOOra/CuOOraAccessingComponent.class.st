"
|miAplicacion|
CuOOra clearSoleInstance.
WAAdmin unregister: 'cuoora'.
miAplicacion := WAAdmin register: CuOOraLoginComponent asApplicationAt: 'cuoora'.
miAplicacion sessionClass: CuOOraSessionWithUser.
"
Class {
	#name : #CuOOraAccessingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombre',
		'contrasena'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #accessing }
CuOOraAccessingComponent >> contrasena [
	^ contrasena
]

{ #category : #accessing }
CuOOraAccessingComponent >> contrasena: anObject [
	contrasena := anObject
]

{ #category : #callbacks }
CuOOraAccessingComponent >> login [
	(self model userWithName: nombre protectedBy: contrasena)
		ifNotNil: [ :unUsuario | self proceedWith: unUsuario ].
	nombre := nil.
	contrasena := nil
]

{ #category : #accessing }
CuOOraAccessingComponent >> model [
	^CuOOra soleInstance
]

{ #category : #accessing }
CuOOraAccessingComponent >> nombre [
	^ nombre
]

{ #category : #accessing }
CuOOraAccessingComponent >> nombre: anObject [
	nombre := anObject
]

{ #category : #private }
CuOOraAccessingComponent >> proceedWith: unUsuario [
	self session usuario: unUsuario.
	self call: CuOOraHomeComponent new.
	self session usuario: nil.
]

{ #category : #rendering }
CuOOraAccessingComponent >> renderButtonsOn: aCanvas [
	self subclassResponsibility
]

{ #category : #rendering }
CuOOraAccessingComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'CuOOra'.
	aCanvas 
		form: [ 
			self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas 
		].

"	aCanvas heading: 'CuOOra'.
	aCanvas paragraph .
	aCanvas table: [
		aCanvas tableRow: [
			aCanvas tableData: [ aCanvas strong: 'Usuario:' ].
			aCanvas tableData: [ aCanvas textInput on: #nombre of: self ] ].
		aCanvas tableRow: [
			aCanvas tableData: [ aCanvas strong: 'Contrase√±a:' ].
			aCanvas tableData: [ aCanvas passwordInput on: #contrasena of: self ] ].
		aCanvas tableRow: [ 
			aCanvas tableData: [ aCanvas space: 5. ].
			aCanvas tableData: [ self renderButtonsOn: aCanvas ]. ].
		]."

]

{ #category : #rendering }
CuOOraAccessingComponent >> renderInputElementsOn: aCanvas [
	aCanvas paragraph: [ aCanvas label: [ aCanvas strong: 'Nombre:'].
	aCanvas space. aCanvas textInput on: #nombre of: self ].
	aCanvas paragraph: [ aCanvas label: [ aCanvas strong: 'Contraseña:' ].
	aCanvas space. aCanvas passwordInput on: #contrasena of: self ]
]

{ #category : #rendering }
CuOOraAccessingComponent >> renderInputElementsOn: aCanvas
	aCanvas: title [ 'CuOOra'.
	aCanvas paragraph: [ aCanvas label: 'Nombre'. aCanvas space. aCanvas textInput on: #nombre of: self ].
	aCanvas paragraph: [ aCanvas label: 'Contrase√±a'. aCanvas space. aCanvas passwordInput on: #contrasena of: self ]
]
