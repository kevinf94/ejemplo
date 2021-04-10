Class {
	#name : #TopicoTest,
	#superclass : #TestCase,
	#instVars : [
		'topico1',
		'topico2'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
TopicoTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
topico1 := (Topico conNombre: 'Deportes' descripcion: 'acerca de deportes').
topico2 := (Topico conNombre: 'Peliculas' descripcion: 'acerca de peliculas').
]

{ #category : #tests }
TopicoTest >> testEsElTopico [
	self assert: (topico1 esElTopico: topico1).
	self deny: (topico1 esElTopico: topico2)
]
