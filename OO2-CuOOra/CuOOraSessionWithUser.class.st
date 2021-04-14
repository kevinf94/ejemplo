"
.
"
Class {
	#name : #CuOOraSessionWithUser,
	#superclass : #WASession,
	#instVars : [
		'usuario'
	],
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #accessing }
CuOOraSessionWithUser >> usuario [
	^usuario
]

{ #category : #accessing }
CuOOraSessionWithUser >> usuario: unUsuario [
	usuario := unUsuario
]
