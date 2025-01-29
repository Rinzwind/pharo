Class {
	#name : 'ReSizeCheckRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReSizeCheckRuleTest >> testRuleNotViolated [

	self class compile: 'method: aCol aCol size > 0 ifFalse: [ aCol collect: [ :each | each ] ] ' classified: 'test-helper'.

	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method:) ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReSizeCheckRuleTest >> testRuleWithIfCollect [

	self class compile: 'method: aCol aCol size > 0 ifTrue: [ aCol collect: [ :each | each ] ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReSizeCheckRuleTest >> testRuleWithIfFalse [

	self class compile: 'method: aCol aCol isEmpty ifFalse: [ aCol do: [ :each | each ] ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReSizeCheckRuleTest >> testRuleWithIfTrue [

	self class compile: 'method: aCol aCol notEmpty ifTrue: [ aCol do: [ :each | each ] ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]
