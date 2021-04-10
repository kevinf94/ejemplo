Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'usuario',
		'pregunta',
		'respuesta',
		'voto',
		'topico'
	],
	#category : #'OO2-CuOOra-TestDeUnidad'
}

{ #category : #internal }
CuOOraTest >> crearPreguntasParaElsistema: unSistema usuario: unUsuario cantidad: unaCantidad topicosDesde: inicio topicosHasta: fin [

	|unosTopicos unTitulo unaDescripcion|
	unosTopicos := OrderedCollection new.
	inicio to: fin do: [ :x | unosTopicos add: (unSistema topicos at: x). ].
	1 to: unaCantidad do: [ :x | 
		unTitulo := ('titulo',x asString).
		unaDescripcion := ('descripcion',x asString).
		sistema agregarPreguntaConTopicos: unosTopicos titulo: unTitulo descripcion: unaDescripcion usuario: usuario.
		].
	
]

{ #category : #internal }
CuOOraTest >> crearRespuestasParaElsistema: unSistema pregunta: unaPregunta usuario: unUsuario cantidad: unaCantidad [

	|unTexto|
	1 to: unaCantidad do: [ :x | 
		unTexto := ('texto',x asString).
		unSistema agregarRespuestaParaLaPregunta: unaPregunta texto: unTexto usuario: unUsuario
		].
	
]

{ #category : #internal }
CuOOraTest >> crearTopicosParaElsistema: unSistema cantidad: unaCantidad [
	1 to: unaCantidad do: [ :x | unSistema agregarTopicoConNombre: ('topico',x asString) descripcion: ('descripcion',x asString) ]
]

{ #category : #internal }
CuOOraTest >> crearUsuariosParaElsistema: unSistema cantidad: unaCantidad [
	1 to: unaCantidad do: [ :x | unSistema crearUnNuevoUsuarioConNombre: ('user',x asString) contrasena: ('pass',x asString) ]
]

{ #category : #running }
CuOOraTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	">>-------arreglar envidia de atributos---------------------------------------------------"
	sistema := CuOOra new.
	
	self crearUsuariosParaElsistema: sistema cantidad: 20.
	self crearTopicosParaElsistema: sistema cantidad: 20.
	
	(sistema usuarios at: 1) agregarUsuarioParaSeguir: (sistema usuarios at: 2). 
	(sistema usuarios at: 1) agregarUsuarioParaSeguir: (sistema usuarios at: 4).
	(sistema usuarios at: 2) agregarUsuarioParaSeguir: (sistema usuarios at: 3).
	(sistema usuarios at: 2) agregarUsuarioParaSeguir: (sistema usuarios at: 5).
	(sistema usuarios at: 3) agregarUsuarioParaSeguir: (sistema usuarios at: 1).
	(sistema usuarios at: 3) agregarUsuarioParaSeguir: (sistema usuarios at: 7).
	
	sistema agregarTopicoDeInteres: (sistema topicos at: 5) paraElUsuario: (sistema usuarios at: 1).
	sistema agregarTopicoDeInteres: (sistema topicos at: 4) paraElUsuario: (sistema usuarios at: 2).
	sistema agregarTopicoDeInteres: (sistema topicos at: 3) paraElUsuario: (sistema usuarios at: 2).
	sistema agregarTopicoDeInteres: (sistema topicos at: 2) paraElUsuario: (sistema usuarios at: 3).
	sistema agregarTopicoDeInteres: (sistema topicos at: 1) paraElUsuario: (sistema usuarios at: 5).
	
	usuario := sistema usuarios at: 1.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 1 topicosDesde: 1 topicosHasta: 2.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 2 topicosDesde: 3 topicosHasta: 3.
	usuario := sistema usuarios at: 2.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 3 topicosDesde: 4 topicosHasta: 5.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 1 topicosDesde: 2 topicosHasta: 2.
	usuario := sistema usuarios at: 3.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 1 topicosDesde: 5 topicosHasta: 7.
	
	pregunta := sistema preguntas at: 1.
	usuario := sistema usuarios at: 3.
	self crearRespuestasParaElsistema: sistema pregunta: pregunta usuario: usuario cantidad: 1.
	usuario := sistema usuarios at: 4.
	self crearRespuestasParaElsistema: sistema pregunta: pregunta usuario: usuario cantidad: 2.
	usuario := sistema usuarios at: 5.
	self crearRespuestasParaElsistema: sistema pregunta: pregunta usuario: usuario cantidad: 1.
	
	pregunta agregarLikeDelUsuario: (sistema usuarios at: 4).
	respuesta := pregunta respuestas at: 2. respuesta agregarLikeDelUsuario: (sistema usuarios at: 5).
	respuesta := pregunta respuestas at: 3. respuesta agregarDislikeDelUsuario: (sistema usuarios at: 3).
	respuesta := pregunta respuestas at: 4. respuesta agregarDislikeDelUsuario: (sistema usuarios at: 7).
]

{ #category : #tests }
CuOOraTest >> testAgregarPreguntaConTopicosTituloDescripcionUsuario [

	|cantidad|
	cantidad := sistema preguntas size.
	
	usuario := sistema usuarios at: 10.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 2 topicosDesde: 10 topicosHasta: 11.
	
	self assert: sistema preguntas size equals: cantidad + 2.
	pregunta := sistema preguntas at: cantidad + 1.
	self assert: pregunta titulo equals: 'titulo1'.
	self assert: pregunta topicos size equals: 2.
	self assert: (pregunta topicos at: 2) nombre equals: 'topico11'.
]

{ #category : #tests }
CuOOraTest >> testAgregarRespuestaParaLaPreguntaTextoUsuario [

	self crearUsuariosParaElsistema: sistema cantidad: 10.
	self crearTopicosParaElsistema: sistema cantidad: 10.
	
	usuario := sistema usuarios at: 1.
	self crearPreguntasParaElsistema: sistema usuario: usuario cantidad: 1 topicosDesde: 1 topicosHasta: 1.
	pregunta := sistema preguntas at: 1.
	
	usuario := sistema usuarios at: 2.
	self crearRespuestasParaElsistema: sistema pregunta: pregunta usuario: usuario cantidad: 1.
	
	respuesta := (sistema preguntas at: 1) respuestas at: 1.
	self assert: respuesta texto equals: 'texto1'.
]

{ #category : #tests }
CuOOraTest >> testAgregarTopicoConNombreDescripcion [

	|cantidad|
	cantidad := sistema topicos size.
	
	sistema agregarTopicoConNombre: 'c' descripcion: 'code'.
	
	self assert: sistema topicos size equals: cantidad + 1.
	self assert: (sistema topicos at: cantidad + 1) nombre equals: 'c'.
]

{ #category : #tests }
CuOOraTest >> testAgregarTopicoDeInteresParaElUsuario [
	
	usuario := sistema usuarios at: 10.
	topico := sistema topicos at: 10.

	sistema agregarTopicoDeInteres: topico paraElUsuario: usuario.
	
	self assert: (usuario topicos at: 1) equals: topico.
	self assert: (usuario topicos at: 1) nombre equals: 'topico10'.
]

{ #category : #tests }
CuOOraTest >> testBorrarLaPregunta [

	|cantidad|
	cantidad := sistema preguntas size.
	
	pregunta := sistema preguntas at: 4.
	sistema borrarLaPregunta: pregunta.
	self assert: sistema preguntas size equals: cantidad - 1.
	"ver si realmente la instancia de la pregunta no esta mas en la coleccion"
]

{ #category : #tests }
CuOOraTest >> testCrearUnNuevoUsuarioConNombreContrasena [
	
	|cantidad|
	cantidad := sistema usuarios size.
	sistema crearUnNuevoUsuarioConNombre: 'juan perez' contrasena: 'asd123'.
	
	self assert: sistema usuarios size equals: cantidad + 1.
	self assert: (sistema usuarios at: cantidad + 1) nombre equals: 'juan perez'.
]

{ #category : #tests }
CuOOraTest >> testObtenerLasPreguntasConElTopico [

	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 1)) size equals: 1.
	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 2)) size equals: 2.
	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 3)) size equals: 2.
	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 4)) size equals: 3.
	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 5)) size equals: 4.
	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 6)) size equals: 1.
	self assert: (sistema obtenerLasPreguntasConElTopico: (sistema topicos at: 20)) size equals: 0.
]

{ #category : #tests }
CuOOraTest >> testObtenerPreguntasRelevantesParaElUsuario [
	
	pregunta := sistema obtenerPreguntasRelevantesParaElUsuario: (sistema usuarios at: 1).
	
	self assert: pregunta size equals: 5.
]

{ #category : #tests }
CuOOraTest >> testObtenerPuntajeDelUsuario [
	self assert: (sistema obtenerPuntajeDelUsuario: (sistema usuarios at: 1)) equals: 61.
	self assert: (sistema obtenerPuntajeDelUsuario: (sistema usuarios at: 2)) equals: 80.
	self assert: (sistema obtenerPuntajeDelUsuario: (sistema usuarios at: 3)) equals: 70.
	self assert: (sistema obtenerPuntajeDelUsuario: (sistema usuarios at: 4)) equals: 100.
	self assert: (sistema obtenerPuntajeDelUsuario: (sistema usuarios at: 5)) equals: 49.
	self assert: (sistema obtenerPuntajeDelUsuario: (sistema usuarios at: 6)) equals: 0.
]

{ #category : #tests }
CuOOraTest >> testObtenerRespuestasDeLaPregunta [
	respuesta := sistema obtenerRespuestasDeLaPregunta: (sistema preguntas at: 1).
	self assert: respuesta size equals: 4.
	
	respuesta := sistema obtenerRespuestasDeLaPregunta: (sistema preguntas at: 2).
	self assert: respuesta size equals: 0.
]

{ #category : #tests }
CuOOraTest >> testPreguntasDelUsuario [

	pregunta := sistema preguntasDelUsuario: (sistema usuarios at: 1).
	self assert: pregunta size equals: 3.
	pregunta := sistema preguntasDelUsuario: (sistema usuarios at: 2).
	self assert: pregunta size equals: 4.
	pregunta := sistema preguntasDelUsuario: (sistema usuarios at: 3).
	self assert: pregunta size equals: 1.
	pregunta := sistema preguntasDelUsuario: (sistema usuarios at: 4).
	self assert: pregunta size equals: 0.
]

{ #category : #tests }
CuOOraTest >> testRespuestasDelUsuario [

	respuesta := sistema respuestasDelUsuario: (sistema usuarios at: 1).
	self assert: respuesta size equals: 0.
	
	respuesta := sistema respuestasDelUsuario: (sistema usuarios at: 4).
	self assert: respuesta size equals: 2.
	
]
