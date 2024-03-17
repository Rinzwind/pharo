"
I provide settings for Morphic appearance (theme, fonts, colors, ...) that can be found and changed in the Settings browser.
"
Class {
	#name : 'PolymorphSystemSettings',
	#superclass : 'Object',
	#classVars : [
		'DesktopColor',
		'DesktopGradientDirection',
		'DesktopGradientFillColor',
		'DesktopGradientOrigin',
		'DesktopImageFileName',
		'DesktopImageLayout',
		'DesktopLogo',
		'DesktopLogoFileName',
		'ShowDesktopLogo',
		'UseDesktopGradientFill'
	],
	#category : 'Settings-Polymorph',
	#package : 'Settings-Polymorph'
}

{ #category : 'settings' }
PolymorphSystemSettings class >> appearanceSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #appearance)
		label: 'Appearance' ;
		description: 'All settings concerned with the look''n feel of your system';
		with: [
			(aBuilder pickOne: #uiThemeClass)
				label: 'User interface theme';
				target: self;
				default: (Smalltalk at: #PharoLightTheme);
				order: 1;
				domainValues: self uiThemeClassChoices.
			self morphicSettingsOn: aBuilder.
			self desktopSettingsOn: aBuilder.
			self soundSettingsOn: aBuilder]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopBackgroundChanged [

	| fill |
	self desktopImageFileName
		ifEmpty: [ self currentWorld world backgroundMorph: nil ]
		ifNotEmpty: [
			[
			self currentWorld
				backgroundImage: (Form fromFileNamed: self desktopImageFileName)
				layout: self desktopImageLayout ]
				on: Error
				do: [  ] ].

	self useDesktopGradientFill
		ifTrue: [
			self currentWorld fillStyle isGradientFill
				ifTrue: [ fill := self currentWorld fillStyle ]
				ifFalse: [ fill := GradientFillStyle new ].
			fill colorRamp: {
					(0.0 -> self desktopColor darker).
					(1.0 -> self desktopGradientFillColor lighter) }.
			fill origin:
				(self currentWorld perform: self desktopGradientOrigin).
			self desktopGradientDirection = #Vertical ifTrue: [
				fill radial: false.
				fill normal: self currentWorld width @ 0.
				fill direction: 0 @ self currentWorld height ].
			self desktopGradientDirection = #Horizontal ifTrue: [
				fill radial: false.
				fill normal: 0 @ self currentWorld height.
				fill direction: self currentWorld width @ 0 ].
			self desktopGradientDirection = #Radial ifTrue: [
				fill radial: true.
				self desktopGradientOrigin = #center
					ifTrue: [
						fill direction: self currentWorld width // 2 @ 0.
						fill normal: 0 @ (self currentWorld height // 2) ]
					ifFalse: [
						fill direction: self currentWorld width @ 0.
						fill normal: 0 @ self currentWorld height ] ].
			self currentWorld fillStyle: fill ]
		ifFalse: [ self currentWorld color: self desktopColor ].

	self currentWorld changed
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopColor [
	^ DesktopColor ifNil: [DesktopColor := self currentWorld defaultWorldColor]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopColor: aColor [
	DesktopColor := aColor.
	self desktopBackgroundChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopColorSettingsOn: aBuilder [
	(aBuilder setting: #desktopColor) label: 'Color';
		 description: 'This is the only color of your desktop if no gradient is used. If you make use of a gradient, then this color is the first one of the gradient';
		 default: PharoDarkTheme current desktopColor;
		with: [(aBuilder setting: #useDesktopGradientFill) label: 'Gradient';
				description: 'If true, then more settings will be available in order to define the desktop background color gradient';
				noOrdering;
				default: false;
				with: [(aBuilder setting: #desktopGradientFillColor) label: 'Other color';
						default: PharoDarkTheme current desktopColor;
						description: 'This is the second color of your gradient (the first one is given by the "Color" setting'.
					(aBuilder pickOne: #desktopGradientDirection) label: 'Direction';
						default: #Vertical;
						domainValues: {#Horizontal. #Vertical. #Radial}.
					(aBuilder pickOne: #desktopGradientOrigin) label: 'Origin';
						domainValues: {
							'Top left' translated -> #topLeft.
							'Top' translated -> #topCenter.
							'Top right' translated -> #topRight.
							'Right' translated -> #rightCenter.
							'Bottom right' translated -> #bottomRight.
							'Bottom' translated -> #bottomCenter.
							'Bottom left' translated -> #bottomLeft.
							'Left' translated -> #leftCenter.
							'Center' translated -> #center}]]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopGradientDirection [
	"#Radial #Vertical or #Horizontal"
	^ DesktopGradientDirection ifNil: [DesktopGradientDirection := #Vertical]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopGradientDirection: aSymbol [
	"#Radial #Vertical or #Horizontal"
	DesktopGradientDirection := aSymbol.
	self desktopBackgroundChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopGradientFillColor [
	^ DesktopGradientFillColor ifNil: [DesktopGradientFillColor := self desktopColor]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopGradientFillColor: aColor [
	DesktopGradientFillColor := aColor.
	self desktopBackgroundChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopGradientOrigin [
	"#topLeft #topCenter #topRight #rightCenter #bottomRight #bottomCenter #bottomLeft #leftCenter #center"
	^ DesktopGradientOrigin ifNil: [DesktopGradientOrigin := #topLeft]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopGradientOrigin: aSymbol [
	"#Radial #Vertical or #Horizontal"
	DesktopGradientOrigin := aSymbol.
	self desktopBackgroundChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopImageFileName [
	^ DesktopImageFileName ifNil: [DesktopImageFileName := '']
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopImageFileName: aFileName [
	DesktopImageFileName := aFileName.
	self desktopBackgroundChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopImageLayout [
	^ DesktopImageLayout ifNil: [DesktopImageLayout := #scaled]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopImageLayout: aSymbol [
	DesktopImageLayout := aSymbol.
	self desktopBackgroundChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopLogo [
	^ DesktopLogo ifNil: [self showDesktopLogo ifTrue: [DesktopLogo := self pharoLogo]]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopLogo: anImageMorph [
	DesktopLogo := anImageMorph
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopLogoChanged [
	self showDesktopLogo
		ifFalse: [self setDesktopLogoWith: nil.
			^ self].
	self desktopLogoFileName
		ifEmpty: [self setDesktopLogoWith: self pharoLogo]
		ifNotEmpty: [[self
				setDesktopLogoWith: (ImageMorph withForm: (Form fromFileNamed: self desktopLogoFileName))]
				on: Error
				do: [self setDesktopLogoWith: self pharoLogo]]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopLogoFileName [
	^ DesktopLogoFileName ifNil: [DesktopLogoFileName := '']
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopLogoFileName: aFileName [
	DesktopLogoFileName = aFileName ifTrue: [^ self].
	DesktopLogoFileName := aFileName.
	self desktopLogoChanged
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> desktopSettingsOn: aBuilder [
	(aBuilder group: #desktopSettings)
		label: 'Desktop';
		target: self;
		noOrdering;
		with: [
			(aBuilder setting: #showDesktopLogo)
				label: 'Show logo' ;
				description: 'If true, then a logo if shown on the top left of the desktop' ;
				default: true;
				with: [
					(aBuilder setting: #desktopLogoFileName)
						type: #FilePathEncoder;
						default: '';
						description: 'The path of an image file for your own logo, the default pharo logo is used if empty.' ;
						label: 'Logo image file name'].
			self desktopColorSettingsOn: aBuilder.
			(aBuilder setting: #desktopImageFileName)
				type: #FilePathEncoder;
				default: '';
				description: 'The path of an image file which will be imported as a form and displayed as your desktop background';
				label: 'Desktop background image file name';
			with: [
				(aBuilder pickOne: #desktopImageLayout) label: 'Layout';
				 description: 'Size and placement of the background image';
				 target: self;
				 order: 0;
				 default: #scaled;
				 domainValues: #(#center #tiled #scaled #scaledAspect
		#topLeft #topCenter #topRight #rightCenter
		#bottomRight #bottomCenter #bottomLeft #leftCenter).
				]]
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> labelAreaLayoutSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder pickOne: #labelAreaLayout)
		label: 'Label area layout' translated;
		parent: #windows;
		target: UITheme;
		targetSelector: #currentSettings;
		default: #platformDependent;
		domainValues: {
			'Platform Dependent' translated -> #platformDependent.
			'macOS' -> #macOS.
			'Windows/Linux' -> #WindowsOrLinux };
		description: 'If Platform Dependent, label area elements are placed as they are in the windows of the current OS.
If macOS, close/collapse/expand boxes are placed on the left, and menu control on the right.
If Windows/Linux, elements are placed in order: menu control, label, collapse/expand/close boxes.'
]

{ #category : 'settings' }
PolymorphSystemSettings class >> morphicHaloSettingsOn: aBuilder [
	(aBuilder group: #halo)
		label: 'Halo';
		parent: #morphic;
		description: 'All halo settings';
		noOrdering;
		with: [
			(aBuilder setting: #cycleHalosBothDirections)
				label: 'Cycle both directions';
				target: Morph;
				default: false;
				description: 'By default, halos only cycle from front-most submorph to parent (shift key down). This setting enables halos to also cycle from top-level morph down through the submorphs (no shift key)'.
			(aBuilder setting: #haloEnclosesFullBounds)
				label: 'Encloses fullbounds';
				default: false;
				target: HaloMorph;
				description: 'If true, halos will enclose the full bounds of the target Morph, rather than just the bounds'.
			(aBuilder setting: #showBoundsInHalo)
				label: 'Exhibits bounds' ;
				target: HaloMorph;
				default: false;
				description: 'If true, halos will include a fine rectangle around the bounds of the target morph.'
		]
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> morphicMenuSettingsOn: aBuilder [
	(aBuilder group: #menu)
		label: 'Menus';
		parent: #morphic;
		description: 'All menu settings' ;
		target: UITheme;
		targetSelector: #currentSettings;
		noOrdering;
		with: [
			(aBuilder setting: #preferGradientFill)
				label: 'Gradient filling' ;
				default: false;
				description: 'If true, then menus will have a gradient look' .
			(aBuilder setting: #flatMenu)
				label: 'Flat appearance' ;
				default: true;
				description: 'If true, then menu will without 3D like borders.' .
			(aBuilder setting: #autoMenuColor)
				label: 'Computed color' ;
				default: false;
				description: 'If true, then the menu color will be computed from world dressing.' .
			(aBuilder setting: #menuColor)
				label: 'Menu color';
				default: (Color r: 0.823069403714565 g: 0.823069403714565 b: 0.823069403714565 alpha: 1.0);
				description: 'The menu color to use if it is not computed automatically (see the ''Computed color'' setting)' .
			(aBuilder setting: #menuSelectionColor)
				label: 'Menu selection color' ;
				default: (Color r: 0.38025415444770283 g: 0.6383186705767351 b: 0.8817204301075269 alpha: 1.0);
				description: 'The background color of a selected menu item' .
			(aBuilder setting: #menuSelectionTextColor)
				description: 'The text color of a selected menu item' ;
				default: Color black;
				label: 'Menu selection text color' .
		]
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> morphicSettingsOn: aBuilder [
	(aBuilder group: #morphic)
		label: 'Morphic';
		description: 'All morphic settings';
		noOrdering;
		with: [
			self morphicWindowsSettingsOn: aBuilder.
			self morphicMenuSettingsOn: aBuilder.
			self morphicHaloSettingsOn: aBuilder.
			(aBuilder setting: #keyboardFocusOnMouseDown)
				label: 'Keyboard focus on mouse down';
				default: true;
				target: ModelMorph;
				description: 'When enabled the mouse button must be clicked within a morph for it to take the keyboard focus.' .
			(aBuilder setting: #mouseOverForKeyboardFocus)
				label: 'Lose keyboard focus when mouse leave';
				target: ModelMorph;
				default: false;
				description: 'When true, the mouse must be over a text or list pane in morphic for keystrokes to be felt, and when the mouse is out over the desktop, the so-called desktop-command-keys, such as cmd-b and cmd-R, are honored.  When false, list panes and text panes in morphic remain sensitive to keystrokes even after the mouse is no longer over the pane.' .
			(aBuilder setting: #balloonHelpEnabled)
				label: 'Balloon Tooltips';
				description: 'If true, tooltips are shown when leaving the cursor on top of a graphic element';
				default: true;
				target: UITheme;
				targetSelector: #currentSettings.
			(aBuilder setting: #editableStringMorph)
				label: 'String morphs are editable';
				target: StringMorph;
				default: false;
				description: 'If true, editing on StringMorph is possible if the shift key is pressed while selecting the morphs.' .
			(aBuilder setting: #defaultYellowButtonMenuEnabled)
				label: 'Show default action click menu';
				target: Morph;
				default: false;
				description: 'If true, populate an action click menu (default context menu).'.
			(aBuilder setting: #easySelectingWorld)
				label: 'Easy selection';
				default: false;
				target: WorldState;
				description: 'If true, select multiple Morphs in the world by dragging a selection box around them.']
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> morphicWindowsSettingsOn: aBuilder [
	(aBuilder group: #windows)
		label: 'Windows';
		description: 'All windows settings';
		noOrdering;
		with: [
			(aBuilder setting: #preferRoundCorner)
				target: UITheme;
				targetSelector: #currentSettings;
				default: false;
				label: 'Rounded corners';
				description: 'If true, then windows, menu and other popups will have their corners rounded.'.
			(aBuilder range: #fullscreenMargin)
						target: SystemWindow;
						default: 0;
						label: 'Fullscreen margin';
						description: 'Specify the amount of space that is let around a windows when it''s opened fullscreen';
						range: (-5 to: 100).
			(aBuilder setting: #fadedBackgroundWindows)
				target: UITheme;
				targetSelector: #currentSettings;
				default: false;
				label: 'Fade background windows';
				description: 'If true then, background windows appear more "washed out" to distinguish from the active window'.
			(aBuilder setting: #fastDragging)
				target: UITheme;
				targetSelector: #currentSettings;
				label: 'Fast dragging';
				default: false;
				description: 'If true, window drag will be done by dragging an outline of the window instead of the whole window. It is very convenient on a slow machine' .
			(aBuilder range: #textEntryFieldMinimumWidth)
				label: 'Text entry dialog width';
				default: 450;
				target: TextEntryDialogWindow;
				selector: #minimumWidth;
				range: (100 to: 800);
				description: 'Set the default text field width of the text entry dialog window' ]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> pharoLogo [
	^ ImageMorph withFormSet: self pharoLogoFormSet
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> pharoLogoContents [
	^ self pharoLogoContents1
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> pharoLogoContents1 [
	^ '
		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'
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> pharoLogoContents2 [
	^ '
		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
		QmCC'
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> pharoLogoForm [
	^ self pharoLogoFormSet asForm
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> pharoLogoFormSet [
	^ FormSet forms: ({ self pharoLogoContents1. self pharoLogoContents2 }
		collect: [ :contents |
			(Form fromBinaryStream: contents base64Decoded readStream) collectColors: [ :color |
				color alpha > 0 ifTrue: [ color / color alpha ] ifFalse: [ color ] ] ])
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> setDesktopLogoWith: aMorph [
	self desktopLogo ifNotNil: [ self desktopLogo delete ].
	self desktopLogo: aMorph.
	self desktopLogo
		ifNotNil: [ :logo |
			logo
				beSticky;
				lock.
			"The logo image should appear just below the menu bar"
			logo position: 10 @ (self currentWorld menubar height + 10).
			self currentWorld backgroundMorph
				ifNil: [ self currentWorld addMorphBack: logo ]
				ifNotNil: [ self currentWorld addMorph: logo inFrontOf: self currentWorld backgroundMorph ] ]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> showDesktopLogo [
	^ ShowDesktopLogo ifNil: [ShowDesktopLogo := true]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> showDesktopLogo: aBoolean [
	ShowDesktopLogo = aBoolean ifTrue: [^ self].
	ShowDesktopLogo := aBoolean.
	self desktopLogoChanged
]

{ #category : 'sound' }
PolymorphSystemSettings class >> soundSettingsOn: aBuilder [
	(aBuilder setting: #soundEnabled)
		label: 'Sound';
		target: SoundSystem;
		default: false;
		noOrdering;
		with: [
			(aBuilder setting: #useThemeSounds)
				label: 'Use theme sounds';
				target: SoundTheme;
				default: true;
				with: [
					(aBuilder pickOne: #soundThemeClass)
						label: 'Sound theme' ;
						target: self;
						domainValues: self soundThemeClassChoices]]
]

{ #category : 'sound' }
PolymorphSystemSettings class >> soundThemeClass [
	^ SoundTheme current class
]

{ #category : 'sound' }
PolymorphSystemSettings class >> soundThemeClass: aSoundThemeClass [
	aSoundThemeClass ifNil: [^ self].
	self soundThemeClass ~= aSoundThemeClass
		ifTrue: [aSoundThemeClass beCurrent]
]

{ #category : 'sound' }
PolymorphSystemSettings class >> soundThemeClassChoices [
	^ SoundTheme allThemeClasses collect: [:c | c themeName -> c]
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> uiThemeClass [
	^ UITheme current class
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> uiThemeClass: aUIThemeClass [
	| themeClass |
	themeClass := aUIThemeClass
		ifNil: [ UITheme standardThemeClass ].
	 themeClass beCurrent
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> uiThemeClassChoices [
	^ UITheme allThemeClasses collect: [:c | c themeName -> c]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> useDesktopGradientFill [
	^ UseDesktopGradientFill ifNil: [UseDesktopGradientFill := false]
]

{ #category : 'desktop' }
PolymorphSystemSettings class >> useDesktopGradientFill: aBoolean [
	UseDesktopGradientFill := aBoolean.
	self desktopBackgroundChanged
]

{ #category : 'morphic' }
PolymorphSystemSettings class >> windowPositionStrategySettingsOn: aBuilder [
	<systemsettings>
	(aBuilder pickOne: #usedStrategy)
		label: 'Window position strategy';
		parent: #windows;
		target: RealEstateAgent;
		default: #cascadeFor:initialExtent:world:;
		domainValues: {'Reverse Stagger' -> #staggerFor:initialExtent:world:. 'Cascade' -> #cascadeFor:initialExtent:world:. 'Standard' -> #standardFor:initialExtent:world:};
		description: 'If Reversed Stagger, windows are placed in free space,
if Cascade, windows are placed in cascade based on current active window or based on cursor position.'
]
