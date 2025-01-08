"
ASTPatternMessageNode is an ASTMessageNode that will match other message nodes without their selectors being equal. 

Instance Variables:
	isCascadeList	<Boolean>	are we matching a list of message nodes in a cascaded message
	isList	<Boolean>	are we matching each keyword or matching all keywords together (e.g., `keyword1: would match a one-argument method whereas `@keywords: would match 0 or more arguments)
"
Class {
	#name : 'OCPatternMessageNode',
	#superclass : 'OCMessageNode',
	#instVars : [
		'isList',
		'isCascadeList'
	],
	#category : 'AST-Core-Pattern',
	#package : 'AST-Core',
	#tag : 'Pattern'
}

{ #category : 'instance creation' }
OCPatternMessageNode class >> receiver: aValueNode selector: aSelector keywordsPositions: positionList arguments: valueNodes [

	^aSelector value asSymbol isPatternVariable
		ifTrue:
			[super
				receiver: aValueNode
				selector: aSelector
				keywordsPositions: positionList asIntegerArray
				arguments: valueNodes]
		ifFalse:
			[OCMessageNode
				receiver: aValueNode
				selector: aSelector
				keywordsPositions: positionList asIntegerArray
				arguments: valueNodes]
]

{ #category : 'matching' }
OCPatternMessageNode >> copyInContext: aDictionary [
	| keywordSelector |
	self isList
		ifTrue: [ ^ aDictionary at: self ].
	keywordSelector := self isSelectorList
		ifTrue: [ aDictionary at: self selectorParts first ]
		ifFalse: [ '' join: (self selectorParts collect: [ :each | aDictionary at: each ])].
	^ OCMessageNode
		receiver: (self receiver copyInContext: aDictionary)
		selector: keywordSelector
		arguments: (self copyList: self arguments inContext: aDictionary)
]

{ #category : 'testing - matching' }
OCPatternMessageNode >> isList [
	^isCascadeList and: [parent isNotNil and: [parent isCascade]]
]

{ #category : 'testing - matching' }
OCPatternMessageNode >> isPatternNode [
	^true
]

{ #category : 'testing - matching' }
OCPatternMessageNode >> isSelectorList [
	^isList
]

{ #category : 'matching' }
OCPatternMessageNode >> match: aNode inContext: aDictionary [
	aNode class == self matchingClass ifFalse: [^false].
	(receiver match: aNode receiver inContext: aDictionary) ifFalse: [^false].
	self isSelectorList
		ifTrue:
			[^(aDictionary at: self selectorParts first ifAbsentPut: [aNode selector])
				== aNode selector and:
						[(aDictionary at: arguments first ifAbsentPut: [aNode arguments])
							= aNode arguments]].
	^self matchArgumentsAgainst: aNode inContext: aDictionary
]

{ #category : 'matching' }
OCPatternMessageNode >> matchArgumentsAgainst: aNode inContext: aDictionary [
	self arguments size = aNode arguments size
		ifFalse: [ ^ false ].
	(self matchSelectorAgainst: aNode inContext: aDictionary)
		ifFalse: [ ^ false ].
	self arguments with: aNode arguments do: [ :first :second |
		(first match: second inContext: aDictionary)
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'matching' }
OCPatternMessageNode >> matchSelectorAgainst: aNode inContext: aDictionary [
	self selectorParts with: aNode selectorParts do: [ :first :second |
		| keyword |
		keyword := aDictionary
			at: first
			ifAbsentPut: [
				first isPatternVariable
					ifTrue: [ second ]
					ifFalse: [ first ] ].
		keyword = second
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'private' }
OCPatternMessageNode >> matchingClass [
	^OCMessageNode
]

{ #category : 'initialization' }
OCPatternMessageNode >> receiver: aValueNode selector: aSymbol keywordsPositions: positionList arguments: valueNodes [
	| message |
	self
		receiver: aValueNode;
		selector: aSymbol;
		keywordsPositions: positionList;
		arguments: valueNodes.

	isCascadeList := isList := false.
	message := self selectorParts first.

	2 to: message size
		do:
			[:i |
			| character |
			character := message at: i.
			character == self listCharacter
				ifTrue: [isList := true]
				ifFalse:
					[character == self cascadeListCharacter
						ifTrue: [isCascadeList := true]
						ifFalse: [^self]]]
]

{ #category : 'accessing' }
OCPatternMessageNode >> sentMessages [
	^ super sentMessages
		remove: self selector ifAbsent: [ ];
		yourself
]