"
Clase para no repetir código y acceder a la lista de usuarios y tópicos del sistema.
"
Class {
	#name : #CuOOraAccessing,
	#superclass : #Object,
	#category : #'OO2-CuOOra-InterfazWeb'
}

{ #category : #accessing }
CuOOraAccessing >> listaDeTopicos [
	^CuOOra soleInstance topicos.
]

{ #category : #accessing }
CuOOraAccessing >> listaDeUsuarios [
	^CuOOra soleInstance usuarios.
]
