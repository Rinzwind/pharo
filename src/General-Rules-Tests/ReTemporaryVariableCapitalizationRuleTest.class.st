Class {
	#name : 'ReTemporaryVariableCapitalizationRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Style',
	#package : 'General-Rules-Tests',
	#tag : 'Style'
}

{ #category : 'tests' }
ReTemporaryVariableCapitalizationRuleTest >> testRuleForArgument [

	self class compile: 'methodWith: Arg ^ Arg' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #methodWith:) size equals: 1 ] ensure: [ (self class >> #methodWith:) removeFromSystem ]
]

{ #category : 'tests' }
ReTemporaryVariableCapitalizationRuleTest >> testRuleForTemporary [

	self class compile: 'methodWithTemp | Tp | Tp := 1. ^ Tp' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #methodWithTemp) size equals: 1 ] ensure: [ (self class >> #methodWithTemp) removeFromSystem ]
]

{ #category : 'tests' }
ReTemporaryVariableCapitalizationRuleTest >> testRuleNotViolatedForArgument [

	self class compile: 'methodWith: arg ^ arg' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #methodWith:) ] ensure: [ (self class >> #methodWith:) removeFromSystem ]
]

{ #category : 'tests' }
ReTemporaryVariableCapitalizationRuleTest >> testRuleNotViolatedForTemporary [

	self class compile: 'methodWithTemp | tp | tp := 1. ^ tp' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #methodWithTemp) ] ensure: [ (self class >> #methodWithTemp) removeFromSystem ]
]
