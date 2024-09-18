"
Managing the refactoring of duplicate classes within the codebase. Duplicate classes can lead to code redundancy, maintenance challenges, and potential inconsistencies. 

# Responsibilities

- Configure the duplicate class refactoring.
- Provide a dialog to write a new class name.
- Provide a selection list of methods to be copied or not..
- Ensure that the refactoring process maintains the integrity and functionality of the original classes.

"
Class {
	#name : 'ReDuplicateClassDriver',
	#superclass : 'ReClassInteractionDriver',
	#instVars : [
		'className',
		'newClassName',
		'rbClass',
		'rbMetaclass',
		'superclassName'
	],
	#category : 'Refactoring-UI-Drivers',
	#package : 'Refactoring-UI',
	#tag : 'Drivers'
}

{ #category : 'accessing' }
ReDuplicateClassDriver class >> className: aClassName [

	^ self new
		className: aClassName;
		yourself
]

{ #category : 'introspection' }
ReDuplicateClassDriver >> className [
	"Answer a <String> representing the class to be copied"
	
	^ className
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> className: aClassName [

	className := aClassName.

]

{ #category : 'accessing' }
ReDuplicateClassDriver >> configureRefactoring [

	refactoring := ReCopyClassRefactoring new.
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> newClass [
	"Answer the new created <Class>"

	^ (self model classNamed: self newClassName) binding value
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> newClassName [
	"Answer a <Symbol> representing the new duplicated class"

	^ newClassName
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> newClassName: anObject [

	newClassName := anObject
]

{ #category : 'execution' }
ReDuplicateClassDriver >> requestNewClass [

	^ requestDialog ifNil: [
		requestDialog := (StClassAndMethodsSelectionPresenter on: self)
			withInstanceMethods: rbClass methods
			withClassMethods: rbMetaclass allMethods;
			baseClassName: self className;
			basePackageName: (self model environment at: self className) packageName;
			onCancel: [ : dialog | dialog close ];
			onAccept: [ :dialog |
				self
					packageName: dialog presenter packageName;
					tagName: dialog presenter tagName;
					newClassName: dialog presenter newClassName;
					superclassName: dialog presenter selectedSuperclass.
				refactoring
					packageName: dialog presenter packageName;
					className: dialog presenter newClassName;
					superclassName: dialog presenter selectedSuperclassName;					
					sourceClass: className;
					instanceMethods: dialog presenter selectedInstanceMethods;
					classMethods: dialog presenter selectedClassMethods.

				dialog close ];
			selectAll;
			openModal;
			yourself ]
]

{ #category : 'execution' }
ReDuplicateClassDriver >> runRefactoring [

	self configureRefactoring.
	self requestNewClass.
	requestDialog window isCancelled
		ifTrue: [ ^ nil ].
	model defineClass: [ :aBuilder |
			aBuilder
				superclass: requestDialog selectedSuperclass;
				name: requestDialog newClassName;
				package: requestDialog packageName ].
	self applyChanges 
]

{ #category : 'execution' }
ReDuplicateClassDriver >> runRefactoring: aReCopyClassRefactoring [ 
	"This is the same as #runRefactoring, but instead of automatically configuring a new empty refactoring we use aReCopyClassRefactoring"

	refactoring := aReCopyClassRefactoring.
	self requestNewClass.
	requestDialog window isCancelled
		ifTrue: [ ^ nil ].
	self applyChanges 
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> scopes: refactoringScopes [

	| selectedClass |
	
	scopes := refactoringScopes.
	model := self refactoringScopeOn: scopes last.
	selectedClass := model environment classes anyOne.	

	rbClass := model classFor: selectedClass.
	rbMetaclass := model classFor: selectedClass class.
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> superclassName [

	^ superclassName
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> superclassName: anObject [

	superclassName := anObject
]

{ #category : 'accessing' }
ReDuplicateClassDriver >> tagName [

	^ tagName
]