"
.
"
Class {
	#name : #CuOOraRegisterComponent,
	#superclass : #CuOOraAccessingComponent,
	#instVars : [
		'existeUsuario'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #private }
CuOOraRegisterComponent >> agregarUsuarioACuoora [
	self model crearUnNuevoUsuarioConNombre: nombre contrasena: contrasena .
]

{ #category : #initialization }
CuOOraRegisterComponent >> initialize [
	super initialize.
	existeUsuario := false.
]

{ #category : #rendering }
CuOOraRegisterComponent >> registerAndLogin [
	(self model userWithName: nombre protectedBy: contrasena)
		ifNil: [ self agregarUsuarioACuoora. self login ].
   existeUsuario := true.
	nombre := nil.
	contrasena := nil.
	
]

{ #category : #rendering }
CuOOraRegisterComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Registrar e Ingresar'
]

{ #category : #rendering }
CuOOraRegisterComponent >> renderContentOn: aCanvas [
	super renderContentOn: aCanvas .
	aCanvas horizontalRule.
	existeUsuario ifTrue: [  
	aCanvas paragraph:[ aCanvas text:'El nombre de usuario ingresado ya existe, intente otro.']].
]
