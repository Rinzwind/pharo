Class {
	#name : 'ReAssignmentWithoutEffectRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReAssignmentWithoutEffectRuleTest >> testRule [

	| critiques |
	self generateMethod: 'method |x| x:=x' classified: 'test-helper'.

	critiques := self myCritiquesOnMethod: self class >> #method.
	self assert: critiques size equals: 1
]

{ #category : 'tests' }
ReAssignmentWithoutEffectRuleTest >> testRuleNotViolated [

	| critiques |
	self generateMethod: 'method |x| x:=1' classified: 'test-helper'.

	critiques := self myCritiquesOnMethod: self class >> #method.
	self assertEmpty: critiques
]
