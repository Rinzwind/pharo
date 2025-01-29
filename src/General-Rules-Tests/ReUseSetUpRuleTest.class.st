Class {
	#name : 'ReUseSetUpRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Design Flaws',
	#package : 'General-Rules-Tests',
	#tag : 'Design Flaws'
}

{ #category : 'tests' }
ReUseSetUpRuleTest >> testRule [

	self class compile: 'initialize' classified: 'initialization'.
	[ self assert: (self myCritiquesOnMethod: self class >> #initialize) size equals: 1 ] ensure: [ (self class >> #initialize) removeFromSystem ]
]

{ #category : 'tests' }
ReUseSetUpRuleTest >> testRuleNotViolated [

	self class compile: 'setUp'.
	[ self assertEmpty: (self myCritiquesOnClass: self class) ] ensure: [ (self class >> #setUp) removeFromSystem ]
]
