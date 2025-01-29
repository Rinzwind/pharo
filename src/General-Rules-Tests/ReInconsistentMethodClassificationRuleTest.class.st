Class {
	#name : 'ReInconsistentMethodClassificationRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Design Flaws',
	#package : 'General-Rules-Tests',
	#tag : 'Design Flaws'
}

{ #category : 'tests' }
ReInconsistentMethodClassificationRuleTest >> testRule [

	self class compile: 'myCritiques super myCritiques' classified: 'accessing'.
	[ self assert: (self myCritiquesOnMethod: self class >> #myCritiques) size equals: 1 ] ensure: [ (self class >> #myCritiques) removeFromSystem ].
	self class compile: 'initialize super initialize' classified: 'accessing'.
	[ self assert: (self myCritiquesOnMethod: self class >> #initialize) size equals: 1 ] ensure: [ (self class >> #initialize) removeFromSystem ]
]

{ #category : 'tests' }
ReInconsistentMethodClassificationRuleTest >> testRuleNotViolated [

	self class compile: 'initialize super initialize' classified: 'initialization'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #initialize) ] ensure: [ (self class >> #initialize) removeFromSystem ]
]
