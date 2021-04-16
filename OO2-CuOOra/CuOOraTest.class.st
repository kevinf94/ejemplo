Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'topic1',
		'topic2',
		'topic3',
		'user1',
		'user2',
		'user3'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #running }
CuOOraTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	|desc|
	sistema := CuOOra new.
	
	topic1 := 'Pharo'. desc := 'Entorno de desarrollo para smalltalk.'.
	topic1 := sistema agregarTopicoConNombre: topic1 descripcion: desc.
	topic2 := 'OO2'. desc := 'Orientación a objetos 2.'.
	topic2 := sistema agregarTopicoConNombre: topic2 descripcion: desc.
	topic3 := 'Info-UNLP'. desc := 'Facultad de Informática de la UNLP.'.
	topic3 := sistema agregarTopicoConNombre: topic3 descripcion: desc.
	
	user1 := sistema crearUnNuevoUsuarioConNombre: 'user1' contrasena: 'user1'.
	user2 := sistema crearUnNuevoUsuarioConNombre: 'user2' contrasena: 'user2'.
	user3 := sistema crearUnNuevoUsuarioConNombre: 'user3' contrasena: 'user3'.
	
	
	
	
	
	
	"ya no sirve:"	
	"|desc|

	sistema := CuOOra new.
	
	topic1 := 'Pharo'. desc := 'Entorno de desarrollo para smalltalk.'.
	topic1 := sistema agregarTopicoConNombre: topic1 descripcion: desc.
	topic2 := 'OO2'. desc := 'Orientación a objetos 2.'.
	topic2 := sistema agregarTopicoConNombre: topic2 descripcion: desc.
	topic3 := 'Info-UNLP'. desc := 'Facultad de Informática de la UNLP.'.
	topic3 := sistema agregarTopicoConNombre: topic3 descripcion: desc.
	
	user1 := sistema crearUnNuevoUsuarioConNombre: 'user1' contrasena: 'user1'.
	user2 := sistema crearUnNuevoUsuarioConNombre: 'user2' contrasena: 'user2'.
	user3 := sistema crearUnNuevoUsuarioConNombre: 'user3' contrasena: 'user3'.
	
	user1 agregarUsuarioParaSeguir: user2.
	user2 agregarUsuarioParaSeguir: user3.
	
	user1 agregarTopicoDeInteres: topic2.
	user2 agregarTopicoDeInteres: topic1.
	user3 agregarTopicoDeInteres: topic3.
	
	ask1 := '¿Cómo se usa Pharo?'. desc := 'Lo instale y no funciona.'.
	ask1 := sistema agregarPreguntaConTopicos: { topic1. topic2. } titulo: ask1 descripcion: desc usuario: user2.
	ask1 agregarLikeDelUsuario: user1.
	ask1 agregarLikeDelUsuario: user3.
	desc := 'Hay que leer el manual.'.
	ans1 := sistema agregarRespuestaParaLaPregunta: ask1 texto: desc usuario: user1.

	ask2 := '¿Dónde esta el centro de estudiantes?'. desc := 'No lo encuentro en el mapa.'.
	ask2 := sistema agregarPreguntaConTopicos: { topic3. } titulo: ask1 descripcion: desc usuario: user2.
	ask2 agregarDislikeDelUsuario: user3.
	ask2 agregarLikeDelUsuario: user1.
	desc := 'Pregunta en la fotocopiadora.'.
	ans2 := sistema agregarRespuestaParaLaPregunta: ask2 texto: desc usuario: user3.
	
	ask3 := '¿Cual es la diferencia entre herencia y composición?'. desc := 'Aprobe Taller, AyED, OO1 y sigo sin entender.'.
	ask3 := sistema agregarPreguntaConTopicos: { topic2. } titulo: ask3 descripcion: desc usuario: user3.
	ask3 agregarDislikeDelUsuario: user1.
	ask3 agregarDislikeDelUsuario: user2.
	desc := 'jajajaja'.
	ans3 := sistema agregarRespuestaParaLaPregunta: ask3 texto: desc usuario: user1.
	ans3 agregarLikeDelUsuario: user2.
	"
]

{ #category : #tests }
CuOOraTest >> testAgregarTopicoConNombreDescripcion [
	"Se verifica la correcta creación de un tópico."

	|topic|
	
	topic := sistema agregarTopicoConNombre: 'Test' descripcion: 'Desc'.
	
	self assert: (sistema tenesElTopico: topic).
	self assert: topic nombre equals: 'Test'.
	self assert: topic descripcion equals: 'Desc'.
]

{ #category : #tests }
CuOOraTest >> testCrearUnNuevoUsuarioConNombreContrasena [
	"Se verifica la correcta creación de un nuevo usuario."
	
	|usuarios user|
	
	usuarios := sistema usuarios.
	user := sistema crearUnNuevoUsuarioConNombre: 'Test' contrasena: 'pass'.
	
	self assert: (usuarios includes: user).
	self assert: user nombre equals: 'Test'.
	self assert: user contrasena equals: 'pass'.
]
