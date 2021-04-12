"
.
"
Class {
	#name : #CuOOraRegisterComponent,
	#superclass : #CuOOraAccessingComponent,
	#instVars : [
		'usuarioExistente'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #private }
CuOOraRegisterComponent >> agregarUsuarioACuoora [
	self model crearUnNuevoUsuarioConNombre: nombre contrasena: contrasena .
]

{ #category : #rendering }
CuOOraRegisterComponent >> registerAndLogin [
	(self usuarioYContrasenaOK)
	ifTrue: [
		(self model existeUsuarioConNombre: nombre)
		ifTrue: [ usuarioExistente := nombre ]
		ifFalse: [ self agregarUsuarioACuoora . self login ]
	].

	nombre := nil.
	contrasena := nil
]

{ #category : #rendering }
CuOOraRegisterComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Registrar e Ingresar'.
	aCanvas space: 3.
	aCanvas submitButton callback: [ self answer. ]; with: 'Volver'.
]

{ #category : #rendering }
CuOOraRegisterComponent >> renderContentOn: aCanvas [
	super renderContentOn: aCanvas .
	aCanvas horizontalRule.
	((usuarioExistente isNotNil) and:[ usuarioExistente isNotEmpty]  ) ifTrue: [  
	aCanvas paragraph:[ aCanvas text:'El nombre de usuario "',usuarioExistente ,'" ya existe, intente otro.']].
]

{ #category : #rendering }
CuOOraRegisterComponent >> usuarioYContrasenaOK [
	^((nombre isNotNil) & (nombre isNotEmpty)  & (contrasena isNotNil) & (contrasena isNotEmpty))
	
]
