Class {
	#name : 'ReStatementsAfterReturnConditionalRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Potential Bugs',
	#package : 'General-Rules-Tests',
	#tag : 'Potential Bugs'
}

{ #category : 'tests' }
ReStatementsAfterReturnConditionalRuleTest >> testRule [

	self class compile: 'method 1 = 1 ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]. 2' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReStatementsAfterReturnConditionalRuleTest >> testRuleNotViolated [

	self class compile: 'method 1 = 1 ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ].' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReStatementsAfterReturnConditionalRuleTest >> testRuleNotViolatedWithNotReturnInBranch [

	self class compile: 'method 1 = 1 ifTrue: [  ] ifFalse: [ ^ 2 ]. 2' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
