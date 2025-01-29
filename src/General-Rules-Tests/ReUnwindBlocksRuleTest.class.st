Class {
	#name : 'ReUnwindBlocksRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReUnwindBlocksRuleTest >> testRuleNotViolatedWithAssignment [

	self class compile: 'method | var | var := [ 1 + 1. 42  ] ensure: [ 2 ] ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReUnwindBlocksRuleTest >> testRuleNotViolatedWithReturn [

	self class compile: 'method ^ [ 1 + 1. 42 ] ensure: [ 2 ] ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReUnwindBlocksRuleTest >> testRuleWithAssignment [

	self class compile: 'method | var | [ 1 + 1. var := 42  ] ensure: [ 2 ] ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReUnwindBlocksRuleTest >> testRuleWithReturn [

	self class compile: 'method [ 1 + 1. ^ 42 ] ensure: [ 2 ] ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]
