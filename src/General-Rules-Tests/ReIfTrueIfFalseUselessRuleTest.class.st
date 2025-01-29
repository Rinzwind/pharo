Class {
	#name : 'ReIfTrueIfFalseUselessRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Design Flaws',
	#package : 'General-Rules-Tests',
	#tag : 'Design Flaws'
}

{ #category : 'tests' }
ReIfTrueIfFalseUselessRuleTest >> testRule [

	self class compile: 'method 1 = 1 ifTrue: [ ^ true ] ifFalse: [ ^ false ] ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReIfTrueIfFalseUselessRuleTest >> testRuleNotViolated [

	self class compile: 'method ^ ((1 = 1) & (2 = 2)) ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
