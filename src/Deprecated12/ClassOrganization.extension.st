Extension { #name : #ClassOrganization }

{ #category : #'*Deprecated12' }
ClassOrganization >> addCategory: aString [

	self deprecated: 'Use #addProtocolNamed: instead.' transformWith: '`@rcv addCategory: `@arg' -> '`@rcv addProtocolNamed: `@arg'.
	self addProtocolNamed: aString
]

{ #category : #'*Deprecated12' }
ClassOrganization >> allCategories [

	self deprecated: 'Use #protocolNames instead.' transformWith: '`@rcv allCategories' -> '`@rcv protocolNames'.
	^ self protocolNames
]

{ #category : #'*Deprecated12' }
ClassOrganization >> categories [

	self deprecated: 'Use #protocolNames instead.' transformWith: '`@rcv categories' -> '`@rcv protocolNames'.
	^ self protocolNames
]

{ #category : #'*Deprecated12' }
ClassOrganization >> categoryOfElement: aSelector [

	self deprecated: 'Use #protocolNameOfElement: instead.' transformWith: '`@rcv categoryOfElement: `@arg' -> '`@rcv protocolNameOfElement: `@arg'.
	^ self protocolNameOfElement: aSelector
]

{ #category : #'*Deprecated12' }
ClassOrganization >> categoryOfElement: aSelector ifAbsent: aBlock [

	self
		deprecated: 'Use #protocolNameOfElement:ifAbsent: instead.'
		transformWith: '`@rcv categoryOfElement: `@arg1 ifAbsent: `@arg2' -> '`@rcv protocolNameOfElement: `@arg1 ifAbsent: `@arg2'.
	^ self protocolNameOfElement: aSelector ifAbsent: aBlock
]

{ #category : #'*Deprecated12' }
ClassOrganization >> listAtCategoryNamed: aName [

	self deprecated: 'Use #methodsInProtocolNamed: instead.' transformWith: '`@rcv listAtCategoryNamed: `@arg' -> '`@rcv methodSelectorsInProtocol: `@arg'.
	^ self methodSelectorsInProtocol: aName
]

{ #category : #'*Deprecated12' }
ClassOrganization >> notifyOfChangedCategoriesFrom: oldProtocolName to: newProtocolName [

	self
		deprecated: 'Use #notifyOfChangedProtocolNamesFrom:to: instead.'
		transformWith: '`@rcv notifyOfChangedCategoriesFrom: `@arg1 to: `@arg2' -> '`@rcv notifyOfChangedProtocolNamesFrom: `@arg1 to: `@arg2'.
	self notifyOfChangedProtocolNamesFrom: oldProtocolName to: newProtocolName
]

{ #category : #'*Deprecated12' }
ClassOrganization >> notifyOfRemovedCategory: protocolName [

	self
		deprecated: 'Use #notifyOfRemovedProtocolNamed: instead.'
		transformWith: '`@rcv notifyOfRemovedCategory: `@arg' -> '`@rcv notifyOfRemovedProtocolNamed: `@arg'.
	self notifyOfRemovedProtocolNamed: protocolName
]

{ #category : #'*Deprecated12' }
ClassOrganization >> removeCategory: protocolName [

	self deprecated: 'Use #removeProtocolIfEmpty: instead.' transformWith: '`@rcv removeCategory: `@arg' -> '`@rcv removeProtocolIfEmpty: `@arg'.
	self removeProtocolIfEmpty: protocolName
]

{ #category : #'*Deprecated12' }
ClassOrganization >> removeEmptyCategories [

	self deprecated: 'Use #removeEmptyProtocols instead.' transformWith: '`@rcv removeEmptyCategories' -> '`@rcv removeEmptyProtocols'.
	self removeEmptyProtocols
]

{ #category : #'*Deprecated12' }
ClassOrganization >> removeProtocol: aProtocol [

	self
		deprecated: 'Use #removeProtocolIfEmpty: since I was also removing only empty protocols.'
		transformWith: '`@rcv removeProtocol: `@arg' -> '`@rcv removeProtocolIfEmpty: `@arg'.
	^ self removeProtocolIfEmpty: aProtocol
]

{ #category : #'*Deprecated12' }
ClassOrganization >> removeProtocolNamed: protocolName [

	self deprecated: 'Use #removeProtocolIfEmpty: instead' transformWith: '`@rcv removeProtocolNamed: `@arg' -> '`@rcv removeProtocolIfEmpty: `@arg'.
	^ self removeProtocolIfEmpty: protocolName
]

{ #category : #'*Deprecated12' }
ClassOrganization >> renameCategory: oldName toBe: newName [

	self
		deprecated: 'Use #renameProtocolNamed:toBe: instead.'
		transformWith: '`@rcv renameCategory: `@arg1 toBe: `@arg2' -> '`@rcv renameProtocolNamed: `@arg1 toBe: `@arg2'.
	self renameProtocolNamed: oldName toBe: newName
]

{ #category : #'*Deprecated12' }
ClassOrganization >> silentlyRenameCategory: oldName toBe: newName [

	self
		deprecated: 'Use #silentlyRenameProtocolNamed:toBe: instead.'
		transformWith: '`@rcv silentlyRenameCategory: `@arg1 toBe: `@arg2' -> '`@rcv silentlyRenameProtocolNamed: `@arg1 toBe: `@arg2'.
	self silentlyRenameProtocolNamed: oldName toBe: newName
]