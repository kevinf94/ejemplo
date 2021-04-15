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
CuOOraLoginComponent >> registerNewUser [
	self call: CuOOraRegisterComponent new
]

{ #category : #rendering }
CuOOraLoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph: '¿No tienes una cuenta?'.
	self renderSignUpButtonOn: aCanvas
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
		callback: [ self registerNewUser ];
		with: 'Registrarse'
]
