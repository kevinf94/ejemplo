"
En un playground ejecutar el siguiente c√≥digo para registrar la aplicaci√≥n:

|miAplicacion|
miAplicacion := WAAdmin register: CuOOraLoginComponent asApplicationAt: 'cuoora'.
miAplicacion sessionClass: CuOOraSessionWithUser.

Tambien puede ser:
|miAplicacion|
CuOOra clearSoleInstance.
WAAdmin unregister: 'cuoora'.
miAplicacion := WAAdmin register: CuOOraLoginComponent asApplicationAt: 'cuoora'.
miAplicacion sessionClass: CuOOraSessionWithUser.
"
Class {
	#name : #CuOOraLoginComponent,
	#superclass : #CuOOraAccessingComponent,
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #callbacks }
CuOOraLoginComponent >> login [
	(self model userWithName: nombre protectedBy: contrasena)
		ifNotNil: [ :unUsuario | self proceedWith: unUsuario ].
	nombre := nil.
	contrasena := nil
]

{ #category : #callbacks }
CuOOraLoginComponent >> registerNewUser [
	self call: RegisterComponent new
]

{ #category : #rendering }
CuOOraLoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	"aCanvas horizontalRule.
	aCanvas paragraph: '¬øNo tienes una cuenta?'.
	self renderSignUpButtonOn: aCanvas"
]

{ #category : #rendering }
CuOOraLoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self login ];
		with: 'Entrar'

]

{ #category : #rendering }
CuOOraLoginComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ "self registerNewUser" ];
		with: 'Registrarse'
]
