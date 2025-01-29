Class {
	#name : 'ReNilBranchRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Design Flaws',
	#package : 'General-Rules-Tests',
	#tag : 'Design Flaws'
}

{ #category : 'tests' }
ReNilBranchRuleTest >> testRuleNotViolated [

	self class compile: 'method 1 < 0 ifTrue: [ 1 ]' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReNilBranchRuleTest >> testRuleWithIfFalse [

	self class compile: 'method 1 < 0 ifFalse: [ 1 ] ifTrue: [ nil ]' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReNilBranchRuleTest >> testRuleWithIfTrue [

	self class compile: 'method 1 < 0 ifTrue: [ 1 ] ifFalse: [ nil ]' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]
