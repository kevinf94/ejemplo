Class {
	#name : #VotoTest,
	#superclass : #TestCase,
	#instVars : [
		'usuario',
		'voto'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
VotoTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	usuario := Usuario conNombre: 'user' contrasena: 'pass'.
	voto := Voto likeDelUsuario: usuario.
]

{ #category : #tests }
VotoTest >> testCambiar [

	self assert: voto esLike.
	voto cambiar.
	self assert: voto esDislike.

]

{ #category : #tests }
VotoTest >> testEsDelUsuario [
	|otroUsuario|
	otroUsuario := Usuario conNombre: 'otro' contrasena: '123'.
	
	self assert: (voto esDelUsuario: usuario).
	self deny: (voto esDelUsuario: otroUsuario).
]

{ #category : #tests }
VotoTest >> testEsDislike [

	voto cambiar.
	self assert: voto esDislike.

]

{ #category : #tests }
VotoTest >> testEsLike [

	self assert: voto esLike.
	
]
