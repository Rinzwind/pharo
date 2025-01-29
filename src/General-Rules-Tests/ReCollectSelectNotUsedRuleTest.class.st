Class {
	#name : 'ReCollectSelectNotUsedRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReCollectSelectNotUsedRuleTest >> testRuleForCollect [

	self class compile: 'method #(1 2 3 4) collect: [ :number | number > 0 ] ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReCollectSelectNotUsedRuleTest >> testRuleForselect [

	self class compile: 'method #(1 2 3 4) select: [ :number | number > 0 ] ' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReCollectSelectNotUsedRuleTest >> testRuleNotViolated [

	self class compile: 'method ^ #(1 2 3 4) select: [ :number | number > 0 ] ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
