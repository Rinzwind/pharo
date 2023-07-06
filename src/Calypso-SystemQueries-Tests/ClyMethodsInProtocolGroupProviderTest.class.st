Class {
	#name : #ClyMethodsInProtocolGroupProviderTest,
	#superclass : #ClyMethodGroupProviderTest,
	#category : #'Calypso-SystemQueries-Tests-Domain'
}

{ #category : #running }
ClyMethodsInProtocolGroupProviderTest >> classSampleWhichHasGroup [
	^ClyClass1FromP1Mock
]

{ #category : #running }
ClyMethodsInProtocolGroupProviderTest >> groupProviderClass [
	^ClyTaggedMethodGroupProvider
]

{ #category : #tests }
ClyMethodsInProtocolGroupProviderTest >> testCreateGroupsForEveryProtocol [

	| groups query |
	self buildGroupsFor: ClySubclassN1OfClass1FromP1Mock.

	groups := builtGroups select: [ :each |
		          each isKindOf: ClyMethodsInProtocolGroup ].
	self
		assert: (groups collect: [ :group | group protocol ] as: Set)
		equals: ClySubclassN1OfClass1FromP1Mock tagsForMethods asSet.
	query := groups first methodQuery.
	self assert: query class equals: ClyMethodsInProtocolQuery.
	self
		assert: query scope
		equals: (ClyClassScope of: ClySubclassN1OfClass1FromP1Mock)
]