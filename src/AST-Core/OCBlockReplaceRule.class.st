"
ASTBlockReplaceRule replaces the matching node by the result of evaluating replaceBlock. This allows arbitrary computation to come up with a replacement.

Instance Variables:
	replaceBlock	<BlockClosure>	The block that returns the node to replace the matching node.

"
Class {
	#name : 'OCBlockReplaceRule',
	#superclass : 'OCReplaceRule',
	#instVars : [
		'replaceBlock'
	],
	#category : 'AST-Core-Matching',
	#package : 'AST-Core',
	#tag : 'Matching'
}

{ #category : 'instance creation' }
OCBlockReplaceRule class >> searchFor: searchString replaceWith: replaceBlock [
	^self new searchFor: searchString replaceWith: replaceBlock
]

{ #category : 'instance creation' }
OCBlockReplaceRule class >> searchFor: searchString replaceWith: replaceBlock when: aBlock [
	^self new
		searchFor: searchString
		replaceWith: replaceBlock
		when: aBlock
]

{ #category : 'instance creation' }
OCBlockReplaceRule class >> searchForMethod: searchString replaceWith: replaceBlock [
	^self new searchForMethod: searchString replaceWith: replaceBlock
]

{ #category : 'instance creation' }
OCBlockReplaceRule class >> searchForMethod: searchString replaceWith: replaceBlock when: aBlock [
	^self new
		searchForMethod: searchString
		replaceWith: replaceBlock
		when: aBlock
]

{ #category : 'instance creation' }
OCBlockReplaceRule class >> searchForTree: aProgramNode replaceWith: replaceBlock [
	^self new searchForTree: aProgramNode replaceWith: replaceBlock
]

{ #category : 'instance creation' }
OCBlockReplaceRule class >> searchForTree: aProgramNode replaceWith: replaceBlock when: aBlock [
	^self new
		searchForTree: aProgramNode
		replaceWith: replaceBlock
		when: aBlock
]

{ #category : 'matching' }
OCBlockReplaceRule >> foundMatchFor: aProgramNode [
	| newNode |
	newNode := replaceBlock value: aProgramNode.
	aProgramNode replaceMethodSource: newNode.
	^newNode
]

{ #category : 'initialization' }
OCBlockReplaceRule >> initialize [
	super initialize.
	replaceBlock := [:aNode | aNode]
]

{ #category : 'private - searching' }
OCBlockReplaceRule >> searchFor: searchString replaceWith: aBlock [
	self searchString: searchString.
	replaceBlock := aBlock
]

{ #category : 'private - searching' }
OCBlockReplaceRule >> searchFor: searchString replaceWith: replBlock when: verifyBlock [
	self searchFor: searchString replaceWith: replBlock.
	verificationBlock := verifyBlock
]

{ #category : 'private - searching' }
OCBlockReplaceRule >> searchForMethod: searchString replaceWith: aBlock [
	self methodSearchString: searchString.
	replaceBlock := aBlock
]

{ #category : 'private - searching' }
OCBlockReplaceRule >> searchForMethod: searchString replaceWith: replBlock when: verifyBlock [
	self searchForMethod: searchString replaceWith: replBlock.
	verificationBlock := verifyBlock
]

{ #category : 'private - searching' }
OCBlockReplaceRule >> searchForTree: aBRProgramNode replaceWith: aBlock [
	searchTree := aBRProgramNode.
	replaceBlock := aBlock
]

{ #category : 'private - searching' }
OCBlockReplaceRule >> searchForTree: aBRProgramNode replaceWith: replBlock when: verifyBlock [
	self searchForTree: aBRProgramNode replaceWith: replBlock.
	verificationBlock := verifyBlock
]