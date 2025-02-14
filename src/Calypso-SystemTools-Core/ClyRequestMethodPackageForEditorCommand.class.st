"
I am a command to request package from the user which should be used as editing method package
"
Class {
	#name : 'ClyRequestMethodPackageForEditorCommand',
	#superclass : 'ClyMethodEditorCommand',
	#category : 'Calypso-SystemTools-Core-Editors-Methods',
	#package : 'Calypso-SystemTools-Core',
	#tag : 'Editors-Methods'
}

{ #category : 'testing' }
ClyRequestMethodPackageForEditorCommand class >> canBeExecutedInMethodEditor: aTool [

	^ true
]

{ #category : 'activation' }
ClyRequestMethodPackageForEditorCommand class >> methodEditorShorcutActivation [
	<classAnnotation>

	^CmdShortcutActivation by: $e meta, $m meta, $p meta for: ClyTextEditorContext
]

{ #category : 'accessing' }
ClyRequestMethodPackageForEditorCommand >> defaultMenuItemName [
	^'Select method package'
]

{ #category : 'accessing' }
ClyRequestMethodPackageForEditorCommand >> description [ 

^'Requests package to be used as editing method package.'
]

{ #category : 'execution' }
ClyRequestMethodPackageForEditorCommand >> execute [
	| packageEditor |
	packageEditor := methodEditor protocolAndPackageEditor.
	packageEditor requestChangeBy: [ packageEditor requestPackage]
]
