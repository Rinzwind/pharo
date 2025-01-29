Class {
	#name : 'RePointRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
RePointRuleTest >> testRule [

	self class compile: 'methodTest ^Point x: 2 y: 3' classified: 'test-helper'.
	self assert: (self myCritiquesOnMethod: self class >> #methodTest) size equals: 1.
	[ "code of the test" ] ensure: [ (self class >> #methodTest) removeFromSystem ]
]

{ #category : 'tests' }
RePointRuleTest >> testRuleNotViolated [

	self class compile: 'x:x y:y ^ x + y' classified: 'test-helper'.
	self class compile: 'methodTest ^self new x: 2 y: 3' classified: 'test-helper'.
	self assertEmpty: (self myCritiquesOnMethod: self class >> #methodTest).
	[ "code of the test" ] ensure: [ (self class >> #methodTest) removeFromSystem ].
	[ "code of the test" ] ensure: [ (self class >> #x:y:) removeFromSystem ]
]
