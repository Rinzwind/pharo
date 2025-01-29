"
A ReDoNotSendSuperInitializeInClassSideRuleTest is a test class for testing the behavior of ReDoNotSendSuperInitializeInClassSideRule
"
Class {
	#name : 'ReShouldSendSuperInitializeAsFirstMessageTest',
	#superclass : 'ReAbstractRuleTestCase',
	#category : 'General-Rules-Tests-Clean Code',
	#package : 'General-Rules-Tests',
	#tag : 'Clean Code'
}

{ #category : 'tests' }
ReShouldSendSuperInitializeAsFirstMessageTest >> testRuleNotViolated [

	self class compile: 'initialize super initialize. 3+4' classified: 'initialization'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #initialize) ] ensure: [ (self class >> #initialize) removeFromSystem ]
]

{ #category : 'tests' }
ReShouldSendSuperInitializeAsFirstMessageTest >> testRuleNotViolatedWithTemps [

	self class compile: 'initialize |a| super initialize. a := 3+4' classified: 'initialization'.
	[ self assertEmpty: (self myCritiquesOnMethod: self class >> #initialize) ] ensure: [ (self class >> #initialize) removeFromSystem ]
]

{ #category : 'tests' }
ReShouldSendSuperInitializeAsFirstMessageTest >> testRuleViolated [

	self class compile: 'initialize 3+4' classified: 'initialization'.
	[ self assert: (self myCritiquesOnMethod: self class >> #initialize) first rule class equals: ReShouldSendSuperInitializeAsFirstMessage ] ensure: [
		(self class >> #initialize) removeFromSystem ]
]

{ #category : 'tests' }
ReShouldSendSuperInitializeAsFirstMessageTest >> testRuleViolatedWithTemps [

	self class compile: 'initialize |a| a := 3+4' classified: 'initialization'.
	[ self assert: (self myCritiquesOnMethod: self class >> #initialize) first rule class equals: ReShouldSendSuperInitializeAsFirstMessage ] ensure: [
		(self class >> #initialize) removeFromSystem ]
]
