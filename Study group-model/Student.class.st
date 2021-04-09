Class {
	#name : #Student,
	#superclass : #Object,
	#instVars : [
		'name',
		'age'
	],
	#category : #'Study group-model'
}

{ #category : #'instance creation' }
Student class >> named: aName age: aNumber [
	^ self new
		name: aName;
		age: aNumber;
		yourself
]

{ #category : #accessing }
Student >> age [
	^ age
]

{ #category : #accessing }
Student >> age: aNumber [
	age := aNumber
]

{ #category : #accessing }
Student >> name [
	^ name
]

{ #category : #accessing }
Student >> name: aString [
	name := aString
]
