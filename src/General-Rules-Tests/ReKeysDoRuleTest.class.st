Class {
	#name : 'ReKeysDoRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Optimization',
	#package : 'General-Rules-Tests',
	#tag : 'Optimization'
}

{ #category : 'tests' }
ReKeysDoRuleTest >> testRuleNotViolatedWithKeys [

	self class compile: 'method: aDictionnary aDictionnary keysDo: [ :key | key ] ' classified: 'test-helper'.

	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method:) ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReKeysDoRuleTest >> testRuleNotViolatedWithValues [

	self class compile: 'method: aDictionnary aDictionnary valuesDo: [ :key | key ] ' classified: 'test-helper'.

	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #method:) ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReKeysDoRuleTest >> testRuleWithKeys [

	self class compile: 'method: aDictionnary aDictionnary keys do: [ :key | key ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]

{ #category : 'tests' }
ReKeysDoRuleTest >> testRuleWithValues [

	self class compile: 'method: aDictionnary aDictionnary values do: [ :key | key ] ' classified: 'test-helper'.

	[ self assert: (self myCritiquesOnMethod: self class >> #method:) size equals: 1 ] ensure: [ (self class >> #method:) removeFromSystem ]
]
