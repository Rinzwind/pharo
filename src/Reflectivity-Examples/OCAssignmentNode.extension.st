Extension { #name : 'OCAssignmentNode' }

{ #category : '*Reflectivity-Examples' }
OCAssignmentNode >> tagType: anObject [
	"record the type of the assigned value"
	variable propertyAt: #types ifAbsentPut: Set new.
	(variable propertyAt: #types) add: anObject class
]
