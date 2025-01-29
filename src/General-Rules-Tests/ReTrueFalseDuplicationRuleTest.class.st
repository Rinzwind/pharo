Class {
	#name : 'ReTrueFalseDuplicationRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReTrueFalseDuplicationRuleTest >> testRule [

	self class compile: 'method self conditional ifTrue: [ self foo. self bar] ifFalse: [ self foo. self ornicar ].  ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReTrueFalseDuplicationRuleTest >> testRuleNotViolated [

	self class compile: 'method self foo. self conditional ifTrue: [ self bar ] ifFalse: [ self ornicar ].  ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
