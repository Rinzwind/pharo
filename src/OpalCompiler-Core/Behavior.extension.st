Extension { #name : 'Behavior' }

{ #category : '*OpalCompiler-Core' }
Behavior >> allTemps [
	^#()
]

{ #category : '*OpalCompiler-Core' }
Behavior >> compile: code [
	"Compile the argument, code, as source code in the context of the
	receiver. Create an error notification if the code can not be compiled.
	The argument is either a string or an object that converts to a string or a
	PositionableStream on an object that converts to a string."

	^self compile: code notifying: nil
]

{ #category : '*OpalCompiler-Core' }
Behavior >> compile: code notifying: requestor [
	"Compile the argument, code, as source code in the context of the
	receiver and insEtall the result in the receiver's method dictionary. The
	second argument, requestor, is to be notified if an error occurs. The
	argument code is either a string or an object that converts to a string or
	a PositionableStream. This method also saves the source code."

	| method |
	method  := self compiler
		source: code;
		requestor: requestor;
		failBlock: (requestor ifNotNil: [ [ ^ nil ] ]); "no failblock if no requestor"
		compile.

	method putSource: code
			withPreamble: [:f | f cr; nextPut: $!; nextChunkPut: 'Behavior method'; cr].
	self addSelector: method selector withMethod: method.
	^ method selector
]

{ #category : '*OpalCompiler-Core' }
Behavior >> compileAll [
	^ self compileAllFrom: self
]

{ #category : '*OpalCompiler-Core' }
Behavior >> compileAllFrom: oldClass [
	"Compile all the methods in the receiver's method dictionary.
	This validates sourceCode and variable references and forces
	all methods to use the current bytecode set"
	oldClass localSelectors do: [:sel | self recompile: sel from: oldClass]
]

{ #category : '*OpalCompiler-Core' }
Behavior >> compiler [
	"Answer a compiler appropriate for source methods of this class."

	^self compilerClass new
		environment: self environment;
		class: self
]

{ #category : '*OpalCompiler-Core' }
Behavior >> compilerClass [
	"Answer a compiler class appropriate for source methods of this class."

	^Smalltalk compilerClass
]

{ #category : '*OpalCompiler-Core' }
Behavior >> outerScope [
	^self environment
]

{ #category : '*OpalCompiler-Core' }
Behavior >> recompile [
	self compileAll
]

{ #category : '*OpalCompiler-Core' }
Behavior >> recompile: selector [
	"Compile the method associated with selector in the receiver's method dictionary."
	^self recompile: selector from: self
]

{ #category : '*OpalCompiler-Core' }
Behavior >> recompile: selector from: oldClass [
	"Compile the method associated with selector in the receiver's method dictionary."

	| method newMethod |

	"Recompilation should be done silently, to avoid putting noise in the system"
	self codeChangeAnnouncer suspendAllWhile: [
		method := oldClass compiledMethodAt: selector.
		newMethod := oldClass compiler
			             source: (oldClass sourceCodeAt: selector);
			             priorMethod: method;
			             class: self;
			             permitFaulty: true;
			             "No need to log recompilation in the sources,
						 	 We are going to reuse the original source pointer."
			             logged: false;
			             install ].

	newMethod sourcePointer: method sourcePointer.
	selector == newMethod selector ifFalse: [
		self error: 'selector changed!' ]
]
