Class {
	#name : 'ReDeadBlockRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReDeadBlockRuleTest >> testRule [

	self class compile: 'method [ self foo ]' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReDeadBlockRuleTest >> testRuleNotViolatedIfBlockAssigned [

	self class compile: 'method | temp |  temp := [ self foo ] ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReDeadBlockRuleTest >> testRuleNotViolatedIfMessageSendToIt [

	self class compile: 'method [ self foo ] value ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReDeadBlockRuleTest >> testRuleNotViolatedIfReturned [

	self class compile: 'method ^ [ self foo ] ' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
