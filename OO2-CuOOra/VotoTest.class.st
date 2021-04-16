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
	"Se verifica el correcto funcionamiento del método: cambiar"

	self assert: voto esLike.
	voto cambiar.
	self assert: voto esDislike.

]

{ #category : #tests }
VotoTest >> testEsDelUsuario [

	"Se verifica el correcto funcionamiento del método: esDelUsuario"
	
	|otroUsuario|
	otroUsuario := Usuario conNombre: 'otro' contrasena: '123'.
	
	self assert: (voto esDelUsuario: usuario).
	self deny: (voto esDelUsuario: otroUsuario).
]

{ #category : #tests }
VotoTest >> testEsDislike [

	"Se verifica el correcto funcionamiento del método: esDislike."

	voto cambiar.
	self assert: voto esDislike.

]

{ #category : #tests }
VotoTest >> testEsLike [

	"Se verifica el correcto funcionamiento del método: esLike."
	self assert: voto esLike.
	
]
