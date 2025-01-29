Class {
	#name : 'ReTemporaryNeitherReadNorWrittenRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReTemporaryNeitherReadNorWrittenRuleTest >> testRule [

	self class compile: 'method |unused|' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReTemporaryNeitherReadNorWrittenRuleTest >> testRuleNotViolated [

	self class compile: 'method |used| used := 1. ^used' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
