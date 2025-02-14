"
I am a command to run all covering tests of selected methods
"
Class {
	#name : 'ClyRunCoveringTestMethodsCommand',
	#superclass : 'ClyRunTestsFromMethodsCommand',
	#category : 'Calypso-SystemPlugins-SUnit-Browser-Commands',
	#package : 'Calypso-SystemPlugins-SUnit-Browser',
	#tag : 'Commands'
}

{ #category : 'testing' }
ClyRunCoveringTestMethodsCommand class >> canBeExecutedInContext: aToolContext [

	^aToolContext selectedMethodItems anySatisfy: [ :each |
		each hasProperty: ClyTestedMethodProperty ]
]

{ #category : 'accessing' }
ClyRunCoveringTestMethodsCommand >> description [

	^ 'Runs all covering tests of selected methods.'
]

{ #category : 'execution' }
ClyRunCoveringTestMethodsCommand >> readParametersFromContext: aToolContext [
	super readParametersFromContext: aToolContext.
	testItems := aToolContext selectedItems
		select: [ :each | each hasProperty: ClyTestedMethodProperty ]
]

{ #category : 'execution' }
ClyRunCoveringTestMethodsCommand >> testResultOf: methodItem [
	^(methodItem getProperty: ClyTestedMethodProperty) testResult
]

{ #category : 'execution' }
ClyRunCoveringTestMethodsCommand >> testSelectorOf: methodItem [

	^(methodItem getProperty: ClyTestedMethodProperty) coveringTest selector
]
