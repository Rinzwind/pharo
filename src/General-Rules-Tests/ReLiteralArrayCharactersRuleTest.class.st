Class {
	#name : 'ReLiteralArrayCharactersRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReLiteralArrayCharactersRuleTest >> testRule [

	self class compile: 'method ^ #($a $b $c)' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReLiteralArrayCharactersRuleTest >> testRuleNotViolated [

	self class compile: 'method ^ #($a $b 1)' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
