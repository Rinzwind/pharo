"
I am a command to extract selected ast node into separate method 
"
Class {
	#name : 'SycExtractMethodCommand',
	#superclass : 'SycSourceCodeRefactoringCommand',
	#instVars : [
		'selectedTextInterval'
	],
	#category : 'SystemCommands-SourceCodeCommands',
	#package : 'SystemCommands-SourceCodeCommands'
}

{ #category : 'testing' }
SycExtractMethodCommand class >> canBeExecutedInContext: aSourceCodeContext [

	^ (super canBeExecutedInContext: aSourceCodeContext) and: [
		  aSourceCodeContext isMethodSelected not ]
]

{ #category : 'testing' }
SycExtractMethodCommand class >> methodEditorShortcutActivation [
	<classAnnotation>

	^CmdShortcutActivation by: $e meta, $m meta for: ClySourceCodeContext
]

{ #category : 'converting' }
SycExtractMethodCommand >> asRefactorings [

	| selectedInterval refactoring |
	selectedInterval := selectedTextInterval ifEmpty: [
		                    sourceNode sourceInterval ].
	refactoring := RBExtractMethodRefactoring
		               extract: selectedInterval
		               from: method selector
		               in: method origin.
	self setUpOptionsOf: refactoring.
	^ { refactoring }
]

{ #category : 'accessing' }
SycExtractMethodCommand >> defaultMenuIconName [
	^ #restart
]

{ #category : 'accessing' }
SycExtractMethodCommand >> defaultMenuItemName [
	^ '(Old refactor) Extract method (no occurrences)'
]

{ #category : 'accessing' }
SycExtractMethodCommand >> description [

	^ 'Extracts selected ast node into separate method.'
]

{ #category : 'execution' }
SycExtractMethodCommand >> readParametersFromContext: aSourceCodeContext [
	super readParametersFromContext: aSourceCodeContext.
	self setUpModelFromContext: aSourceCodeContext.
	selectedTextInterval := aSourceCodeContext selectedTextInterval
]

{ #category : 'execution' }
SycExtractMethodCommand >> setUpOptionToChangeExtractionClass: refactoring [

	refactoring setOption: #extractionClass toUse: [ :ref | | cls superclasses |
		cls := ref methodClass realClass.
		superclasses := cls allSuperclasses reversed copyWithoutAll: { Object . ProtoObject }.
		superclasses ifNotEmpty: [
			cls := self morphicUIManager
				chooseFrom: ((superclasses, {cls}) collect: #name)
				values: superclasses, {cls}
				title: 'Choose the class where you want to extract the method'
		].
		cls ifNil: [
			self inform: 'Command aborted, you must select a class.'.
			CmdCommandAborted signal ].
		cls ]
]

{ #category : 'execution' }
SycExtractMethodCommand >> setUpOptionToChangeMethodNameDuring: refactoring [

	| dialog |
	refactoring setOption: #methodName toUse: [ :methodName :ref | | invalidArgs |
		invalidArgs := self computeInvalidArgNamesForSelector: method selector.
		dialog := StMethodNameEditorPresenter
			openOn: methodName
			withInvalidArgs: invalidArgs
			canRenameArgs: true
			canRemoveArgs: false
			canAddArgs: false.
		dialog cancelled ifTrue: [ CmdCommandAborted signal ].
		methodName ]
]

{ #category : 'execution' }
SycExtractMethodCommand >> setUpOptionToOverrideExistingMethodDuring: aRefactoring [

	aRefactoring setOption: #alreadyDefined toUse:  [ :ref :class :selector |
		ref refactoringWarning: 'Method ', selector printString, ' will override method in ', class name]
]

{ #category : 'execution' }
SycExtractMethodCommand >> setUpOptionsOf: refactoring [

	self initializeDefaultOptionsOf: refactoring.
	self setUpOptionToChangeExtractionClass: refactoring.

	self setUpOptionToOverrideExistingMethodDuring: refactoring.
	self setUpOptionToChangeMethodNameDuring: refactoring
]
