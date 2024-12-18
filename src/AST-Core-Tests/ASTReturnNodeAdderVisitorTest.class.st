Class {
	#name : 'ASTReturnNodeAdderVisitorTest',
	#superclass : 'ASTParseTreeTest',
	#category : 'AST-Core-Tests-Visitors',
	#package : 'AST-Core-Tests',
	#tag : 'Visitors'
}

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenArrayExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: '{ x . ''a'' . #a }'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ { x . ''a'' . #a }'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenAssignmentExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: 'a := self foo'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ a := self foo'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenBlockExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: '[ a := self foo ]'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ [ a := self foo ]'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenCascadeMessageExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: 'self foo; bar; end'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ self foo; bar; end'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenLiteralExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: '1'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ 1'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenMessageSendExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: 'self foo'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ self foo'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenReturnNodeExpectNoChanges [

	| expression visitor result |
	expression := Parser parseExpression: '^ 2'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	self assert: expression equals: result
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenSequenceExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: 'self foo. self bar'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: 'self foo. ^ self bar'.
	self assert: result equals: expect
]

{ #category : 'tests' }
ASTReturnNodeAdderVisitorTest >> testAddReturnWhenVariableExpectReturnAdded [

	| expression visitor result expect |
	expression := Parser parseExpression: 'x'.
	visitor := ASTReturnNodeAdderVisitor new.
	result := visitor visit: expression.
	
	expect := Parser parseExpression: '^ x'.
	self assert: result equals: expect
]