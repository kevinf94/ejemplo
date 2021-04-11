"
.
"
Class {
	#name : #CuOOraRegisterComponent,
	#superclass : #CuOOraAccessingComponent,
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #private }
CuOOraRegisterComponent >> agregarUsuarioACuoora [
	self model crearUnNuevoUsuarioConNombre: nombre contrasena: contrasena .
]

{ #category : #rendering }
CuOOraRegisterComponent >> registerAndLogin [
	(self model userWithName: nombre protectedBy: contrasena)
		ifNil: [ self agregarUsuarioACuoora. self login ].
	nombre := nil.
	contrasena := nil
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
	aCanvas paragraph:[ aCanvas text:'Registrese con un nombre de usuario inexistente']
]
