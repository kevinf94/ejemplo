Class {
	#name : #StudyGroup,
	#superclass : #Object,
	#instVars : [
		'students'
	],
	#category : #'Study group-model'
}

{ #category : #accessing }
StudyGroup >> addStudent: aStudent [
	students add: aStudent
]

{ #category : #accessing }
StudyGroup >> ageAverage [
	^ (students collect: [ :each | each age ]) average
]

{ #category : #initialization }
StudyGroup >> initialize [
	students := OrderedCollection new
]

{ #category : #accessing }
StudyGroup >> students [
	^ students
]
