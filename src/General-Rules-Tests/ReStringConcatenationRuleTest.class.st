Class {
	#name : 'ReStringConcatenationRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReStringConcatenationRuleTest >> testRule [

	self class compile: 'method #(1 2 3) do: [ :each | string := string, each asString].' classified: 'test-helper'.
	[ self assert: (self myCritiquesOnMethod: self class >> #method) size equals: 1 ] ensure: [ (self class >> #method) removeFromSystem ]
]

{ #category : 'tests' }
ReStringConcatenationRuleTest >> testRuleNotViolated [

	self class compile: 'method String streamContents: [:s | #(1 2 3)  do: [:each | s nextPutAll: each asString]]' classified: 'test-helper'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method) ] ensure: [ (self class >> #method) removeFromSystem ]
]
