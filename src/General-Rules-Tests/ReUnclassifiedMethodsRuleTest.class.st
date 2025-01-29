Class {
	#name : 'ReUnclassifiedMethodsRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Style',
	#package : 'General-Rules-Tests',
	#tag : 'Style'
}

{ #category : 'tests' }
ReUnclassifiedMethodsRuleTest >> testRule [

	self class compile: 'method'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReUnclassifiedMethodsRuleTest >> testRuleNotViolated [

	self class compile: 'method ^ 1' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
