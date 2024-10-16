"
I am a refactoring condition that checks if a method defined in `class` is called using ""super"" from a class in the `targetClass` subclasses (except for `class` and its subclasses). For clarity, `class` is one of `targetClass` subclasses.

I'm a refactoring condition (often used for PullUp method). I check whether the sibling methods would be impacted because they would be doing a super call to the method that would be replaced by the pulled method. 

```
A >> foo ^ 11

   B >> bar ^ super foo

	C >> foo ^ 34
```

From class `C`, `B` is a sibling that is doing a supercall to `A foo`.
"
Class {
	#name : 'ReMethodsHaveNoSuperCallInSiblingsCondition',
	#superclass : 'ReMethodsCondition',
	#instVars : [
		'class',
		'selectors',
		'targetSuperclass'
	],
	#category : 'Refactoring-Core-Conditions',
	#package : 'Refactoring-Core',
	#tag : 'Conditions'
}

{ #category : 'private' }
ReMethodsHaveNoSuperCallInSiblingsCondition >> checkSiblingSuperSendsFrom: aRBClass [
	"Checks if `aRBClass` selector sends super message to one of the `selectors`
	from the `class`.
	If that stands and the super message selector is defined in `class` or one of its superclasses
	warn the user.
	Repeat the process for all subclasses of `aRBClass`"

	aRBClass selectors do: [ :each |
		| tree |
		tree := aRBClass parseTreeForSelector: each.
		tree ifNotNil: [
			tree superMessages do: [ :aSelector |
				(selectors includes: aSelector) ifTrue: [
					| definer |
					definer := aRBClass superclass whichClassIncludesSelector:  aSelector.

					(definer isNotNil and: [ class includesClass: definer ]) ifTrue: [
						violators add: { aSelector. aRBClass. each }  ] ] ] ] ].
	aRBClass allSubclasses do: [ :each |
		self checkSiblingSuperSendsFrom: each ]
]

{ #category : 'private' }
ReMethodsHaveNoSuperCallInSiblingsCondition >> checkSuperSendsFromSiblings [
	"Checks if a class in the `targetClass` subclasses (except for `class` and its subclasses)
	send super message to one of the selected messages."

	| siblings |
	targetSuperclass name == #Object ifTrue: [ ^ self ].
	siblings := targetSuperclass subclasses reject: [:each | each = class].
	siblings do: [:aRBClass | self checkSiblingSuperSendsFrom: aRBClass]
]

{ #category : 'initialization' }
ReMethodsHaveNoSuperCallInSiblingsCondition >> class: aRBClass targetSuperclass: aRBClass2 selectors: aCollection [ 
	class := aRBClass.
	targetSuperclass := aRBClass2.
	selectors := aCollection
]

{ #category : 'displaying' }
ReMethodsHaveNoSuperCallInSiblingsCondition >> violationMessageOn: aStream [
	| messageSent senderClass senderMessage |
	
	self violators do: [ :violator |
		messageSent := violator at: 1.
		senderClass := violator at: 2.
		senderMessage := violator at: 3.
		
		aStream
			nextPutAll: senderClass name;
			nextPutAll: '>>';
			nextPutAll: senderMessage;
			nextPutAll: ' sends ''';
			nextPutAll: messageSent;
			nextPutAll: ''' to super';
			space ]
]

{ #category : 'accessing' }
ReMethodsHaveNoSuperCallInSiblingsCondition >> violators [
	violators ifNotNil: [ ^ violators ].
	violators := #() asOrderedCollection.
	self checkSuperSendsFromSiblings.
	^ violators
]