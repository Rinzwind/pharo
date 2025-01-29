Class {
	#name : 'ReNotOptimizedIfRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReNotOptimizedIfRuleTest >> testRule [

	self class compile: 'method: anObject anObject ifTrue: 1 ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReNotOptimizedIfRuleTest >> testRuleNotViolated [

	self class compile: 'method: anObject anObject ifTrue: [ ^ 1 ] ' classified: 'test-helper'.

	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method:) ] ensure: [ (self class >> #method:) removeFromSystem ]
]
