Class {
	#name : #CuOOraPerfilComponent,
	#superclass : #CuOOrLayoutComponent,
	#instVars : [
		'usuario'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #'instance creation' }
CuOOraPerfilComponent class >> conUsuario: unUsuario [
	^self new conUsuario: unUsuario; yourself.
]

{ #category : #'instance creation' }
CuOOraPerfilComponent >> conUsuario: unUsuario [
	usuario := unUsuario
]

{ #category : #rendering }
CuOOraPerfilComponent >> renderCuerpoOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas heading level: 1; with: [ 
			aCanvas text: 'Preguntas de ', usuario nombre, ':'.
		].
		aCanvas submitButton callback: [  ]; with: 'Seguir a ', usuario nombre.
	].

]
