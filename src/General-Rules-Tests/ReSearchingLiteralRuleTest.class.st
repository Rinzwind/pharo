Class {
	#name : 'ReSearchingLiteralRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReSearchingLiteralRuleTest >> testRule [

	self class compile: 'method: aValue aValue = 1 or: [ aValue = 2 or: [ aValue = 3 ] ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 2 ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReSearchingLiteralRuleTest >> testRuleNotViolated [

	self class compile: 'method: aValue #(1 2 3) includes: aValue ' classified: 'test-helper'.

	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method:) ] ensure: [ (self class >> #method:) removeFromSystem ]
]
