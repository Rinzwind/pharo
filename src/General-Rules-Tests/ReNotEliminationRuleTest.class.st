Class {
	#name : 'ReNotEliminationRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReNotEliminationRuleTest >> testRuleWithEvaluator [

	self class compile: 'method (1 < 3) not' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReNotEliminationRuleTest >> testRuleWithIfTrue [

	self class compile: 'method true not ifTrue: [ true ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReNotEliminationRuleTest >> testRuleWithSelect [

	self class compile: 'method: aCol aCol select: [ :elem | elem not] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]
