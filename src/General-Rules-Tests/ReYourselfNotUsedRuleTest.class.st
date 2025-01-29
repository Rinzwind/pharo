Class {
	#name : 'ReYourselfNotUsedRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReYourselfNotUsedRuleTest >> testRule [

	self class compile: 'methodTest self class yourself' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #methodTest) size equals: 1 ] ensure: [ (self class >> #methodTest) removeFromSystem ]
]

{ #category : 'tests' }
ReYourselfNotUsedRuleTest >> testRuleNotViolated [

	self class compile: 'methodTest ^ self yourself' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #methodTest) ] ensure: [ (self class >> #methodTest) removeFromSystem ]
]
