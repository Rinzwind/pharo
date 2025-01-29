Class {
	#name : 'ReUnoptimizedAndOrRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReUnoptimizedAndOrRuleTest >> testRule [

	self class compile: 'method (true and: false) and: true' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReUnoptimizedAndOrRuleTest >> testRuleNotViolated [

	| critiques | 
	
	self class compile: 'method true and: [ false and: [ true ] ]' classified: 'test-helper'. 
	[ critiques := self myCritiquesOnMethod: self class >> #method.
	self assertEmpty: critiques ] ensure: [ (self class >> #method) removeFromSystem ]
]
