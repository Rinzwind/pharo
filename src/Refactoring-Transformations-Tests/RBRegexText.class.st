Class {
	#name : 'RBRegexText',
	#superclass : 'TestCase',
	#category : 'Refactoring-Transformations-Tests',
	#package : 'Refactoring-Transformations-Tests'
}

{ #category : 'tests' }
RBRegexText >> testRegexWithNoStartingAcronym [
	
	| refact |
	refact := RBRegexRefactoring new replace: '^(.*)$' with: 'RB','$1'. 
	self assert: (refact execute: 'YKFoo') equals: 'RBYKFoo'

]

{ #category : 'tests' }
RBRegexText >> testRegexWithTwoAcronyms [
	
	| refact |
	refact := RBRegexRefactoring new replace: '^YK(.*)$' with: 'RB','$1'. 
	self assert: (refact execute: 'YKFoo') equals: 'RBFoo'

]
