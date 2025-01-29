Class {
	#name : 'ReEqualsTrueRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReEqualsTrueRuleTest >> testRule [

	self class compile: 'method: isFoo ^ isFoo == false ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReEqualsTrueRuleTest >> testRuleNotViolated [

	self class compile: 'method: isFoo ^ isFoo ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method:) ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReEqualsTrueRuleTest >> testRuleWithBoolAsArgument [

	self class compile: 'method: isFoo ^ true == isFoo ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]
