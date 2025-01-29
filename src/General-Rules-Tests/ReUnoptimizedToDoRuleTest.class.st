Class {
	#name : 'ReUnoptimizedToDoRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReUnoptimizedToDoRuleTest >> testRule [

	self class compile: 'method (1 to: 10) do: [ :each | each ] ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReUnoptimizedToDoRuleTest >> testRuleNotViolated [

	self class compile: 'method 1 to: 10 do: [ :each | each ] ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
