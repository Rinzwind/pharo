Class {
	#name : 'BaselineOfMisc',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMisc',
	#package : 'BaselineOfMisc'
}

{ #category : 'baselines' }
BaselineOfMisc >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'PharoDocComment';
			package: 'STON-Text support';
			package: 'System-CommandLine-TextSupport';
			package: 'Files-Prompt';
			package: 'System-SourcesCondenser' ]
]
