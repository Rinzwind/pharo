"
I am the node that the link is installed on
"
Class {
	#name : 'RFNodeReification',
	#superclass : 'RFReification',
	#category : 'Reflectivity-Reifications',
	#package : 'Reflectivity',
	#tag : 'Reifications'
}

{ #category : 'plugin interface' }
RFNodeReification class >> entities [
	^{OCProgramNode}
]

{ #category : 'plugin interface' }
RFNodeReification class >> key [
	^#node
]

{ #category : 'generate' }
RFNodeReification >> genForASTProgramNode [
	^OCLiteralNode value: entity
]
