Class {
	#name : #StudentEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'student',
		'newName',
		'newAge'
	],
	#category : #'Study group-ui'
}

{ #category : #'instance creation' }
StudentEditorComponent class >> student: aStudent [
	^ self new
		student: aStudent;
		yourself
]

{ #category : #callbacks }
StudentEditorComponent >> accept [
	student name: newName.
	student age: newAge asNumber.
	self answer.
	
]

{ #category : #callbacks }
StudentEditorComponent >> cancel [
	student := nil. 
	self answer.
	
]

{ #category : #accessing }
StudentEditorComponent >> newAge [
	^ newAge
]

{ #category : #accessing }
StudentEditorComponent >> newAge: aString [
	newAge := aString 
]

{ #category : #accessing }
StudentEditorComponent >> newName [
	^ newName
]

{ #category : #accessing }
StudentEditorComponent >> newName: aString [
	newName := aString
]

{ #category : #rendering }
StudentEditorComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Nombre: '.
					aCanvas textInput on: #newName of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Edad: '.
					aCanvas textInput on: #newAge of: self ].
			aCanvas button
				callback: [ self accept ];
				with: 'Guardar'.
			aCanvas space.
			aCanvas button
				callback: [ self cancel ];
				with: 'Cancelar' ]
]

{ #category : #accessing }
StudentEditorComponent >> student [
	^ student
]

{ #category : #accessing }
StudentEditorComponent >> student: aStudent [
	student := aStudent.
	newName := aStudent name.
	newAge := aStudent age
]
