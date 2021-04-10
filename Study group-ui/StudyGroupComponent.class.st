"
WAAdmin register: StudyGroupComponent asApplicationAt: 'students'
"
Class {
	#name : #StudyGroupComponent,
	#superclass : #WAComponent,
	#instVars : [
		'group',
		'var'
	],
	#category : #'Study group-ui'
}

{ #category : #callbacks }
StudyGroupComponent >> edit: aStudent [
	self call: (StudentEditorComponent student: aStudent)
]

{ #category : #initialization }
StudyGroupComponent >> initialize [
	super initialize.
	group := StudyGroup new
]

{ #category : #callbacks }
StudyGroupComponent >> newStudent [
	| editor |
	editor := StudentEditorComponent student: Student new.
	self call: editor.
	editor student ifNotNil: [ group addStudent: editor student ]
]

{ #category : #rendering }
StudyGroupComponent >> renderContentOn: aCanvas [
	aCanvas
		unorderedList: [ group students
				do: [ :each | 
					aCanvas listItem: [ aCanvas anchor
								callback: [ self edit: each ];
								with: each name ] ] ].
	aCanvas anchor
		callback: [ self newStudent ];
		with: [ aCanvas button: 'Add' ]
]
