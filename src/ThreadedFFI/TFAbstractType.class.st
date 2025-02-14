"
I am an abstract class with the common behavior of the TFTypes.
A TFType knows how to marshall / unmarshall in a normal call and in a callback.
"
Class {
	#name : 'TFAbstractType',
	#superclass : 'FFIExternalReference',
	#category : 'ThreadedFFI-Types',
	#package : 'ThreadedFFI',
	#tag : 'Types'
}

{ #category : 'size' }
TFAbstractType >> byteSize [

	^ self subclassResponsibility
]

{ #category : 'reading' }
TFAbstractType >> callbackReadValue: anExternalAddress [

	^ self readValue: anExternalAddress offset: 1
]

{ #category : 'writing' }
TFAbstractType >> callbackWrite: aNumber into: anExternalAddress [

	self write: aNumber into: anExternalAddress
]

{ #category : 'accessing' }
TFAbstractType >> isValid [

	^ handle isNull not
]

{ #category : 'marshalling' }
TFAbstractType >> optimizeFor: aFFIFunctionArgument in: anIRBuilder ifCannot: aFullBlockClosure [ 
	
	"Just doing the non-optimized version"
	aFullBlockClosure value
]

{ #category : 'reading' }
TFAbstractType >> readReturnValue: anExternalAddress [

	^ self subclassResponsibility
]

{ #category : 'reading' }
TFAbstractType >> readValue: anExternalAddress [

	^ self readValue: anExternalAddress offset: 1
]

{ #category : 'reading' }
TFAbstractType >> readValue: anExternalAddress offset: offset [

	^ self subclassResponsibility
]

{ #category : 'private' }
TFAbstractType >> validate [

	^ self subclassResponsibility
]

{ #category : 'writing' }
TFAbstractType >> write: aNumber into: anExternalAddress [

	self subclassResponsibility
]
