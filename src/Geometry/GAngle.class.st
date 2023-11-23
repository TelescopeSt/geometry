"
Description
--------------------

I represent a geometric angle. 

For now I can manage angle in radians or degrees.

If the angle is not in [0;2π[ , I'll take care to convert it in order to store the angle as a radian value in [0;2π[.

Examples
--------------------

	90 degrees. ""90.0°""

	(0.5 * Float pi)  radians. ""90.0°""
	
	0.5π radians. ""90.0°""	
	
	450 degrees. ""90.0°""
	
	0.5π radians + 0.5π radians. ""180.0°""
	
	0.5π radians - 0.25π radians. ""45.0°""
	
	0.5π radians * 6. ""180.0°""
	
	6 * 0.5π radians. ""180.0°""
	
	90 degrees < 100 degrees. ""true""
	
	90 degrees < -270 degrees. ""false""
	
	90 degrees < 460 degrees. ""false""
	
	0 radians isZero. ""true""
	
	90 degrees explementary. ""270.0°""
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	radians:		<aNumber>		The angle in radians in bounds [0;2π[

"
Class {
	#name : #GAngle,
	#superclass : #GeometryObject,
	#instVars : [
		'radians'
	],
	#classVars : [
		'RightAngle',
		'StraightAngle',
		'TwoPi',
		'ZeroAngle'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GAngle class >> degrees: anInteger [ 
	^ self radians: anInteger degreesToRadians
]

{ #category : #'class initialization' }
GAngle class >> initialize [
	TwoPi := 2π.
	ZeroAngle := 0 rads.
	RightAngle := 0.5π rads.
	StraightAngle := 1π rads
]

{ #category : #'instance creation' }
GAngle class >> radians: aNumber [
	^ self new
		initializeWith: aNumber;
		yourself
]

{ #category : #'instance creation' }
GAngle class >> rads: aNumber [
	^ self radians: aNumber
]

{ #category : #arithmetic }
GAngle >> * anInteger [ 
	^ anInteger multiplyWithAngle: self
]

{ #category : #arithmetic }
GAngle >> + aGAngle [ 
	^ aGAngle addWithAngle: self
]

{ #category : #arithmetic }
GAngle >> - aGAngle [ 
	^ aGAngle substractWithAngle: self
]

{ #category : #arithmetic }
GAngle >> / anInteger [ 
	^ anInteger divideWithAngle: self
]

{ #category : #comparison }
GAngle >> < aGAngle [ 
	^ self rads < aGAngle rads
]

{ #category : #comparison }
GAngle >> <= aGAngle [ 
	^ (self > aGAngle) not
]

{ #category : #comparing }
GAngle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ (radians - anObject rads) =~ 0 or: [ (radians - anObject rads) =~ TwoPi ]
]

{ #category : #comparison }
GAngle >> > aGAngle [ 
	^ aGAngle < self
]

{ #category : #comparison }
GAngle >> >= aGAngle [ 
	^ aGAngle <= self
]

{ #category : #arithmetic }
GAngle >> adaptToNumber: anInteger andSend: aString [ 
	(#(#/ #+) anySatisfy: [ :forgivenSelector | aString = forgivenSelector ]) ifTrue: [ self error: 'Cannot execute ' , aString , ' on an Integer with an angle' ]. "I think we can do better than an if here but no time."
	^ self perform: aString with: anInteger
]

{ #category : #arithmetic }
GAngle >> addWithAngle: aGAngle [ 
	^ (self rads + aGAngle rads) rads
]

{ #category : #arithmetic }
GAngle >> cos [
	^ self rads cos
]

{ #category : #converting }
GAngle >> degreeNumber [
	^ self rads radiansToDegrees
]

{ #category : #accessing }
GAngle >> explementary [
	^ (0 - self rads) rads
]

{ #category : #comparing }
GAngle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ radians hash
]

{ #category : #initialization }
GAngle >> initializeWith: aNumber [ 
	radians := aNumber.
	radians := radians \\ TwoPi.
	radians negative ifTrue: [ radians := radians + TwoPi ]
]

{ #category : #testing }
GAngle >> isAcute [
	^ self > 0 rads and: [ self < RightAngle ]
]

{ #category : #testing }
GAngle >> isObtuse [
	^ self > RightAngle and: [ self < StraightAngle ]
]

{ #category : #testing }
GAngle >> isReflex [
	^ self > StraightAngle and: [ self rads < TwoPi ]
]

{ #category : #testing }
GAngle >> isRight [
	^ self = RightAngle
]

{ #category : #testing }
GAngle >> isStraight [
	^ self = StraightAngle
]

{ #category : #testing }
GAngle >> isZero [
	^ self = ZeroAngle
]

{ #category : #arithmetic }
GAngle >> multiplyWithAngle: aGAngle [ 
	self error: 'Not possible to multiply an angle by another angle'
]

{ #category : #printing }
GAngle >> printOn: aStream [
	aStream
		nextPutAll: (self degreeNumber asString truncateTo: 10);
		nextPutAll: '°'
]

{ #category : #converting }
GAngle >> radianNumber [

	self
		deprecated: 'Please use #rads instead'
		transformWith: '`@receiver radianNumber' -> '`@receiver rads'.
	^ self rads
]

{ #category : #accessing }
GAngle >> radians [

	self
		deprecated: 'Please use #rads instead'
		transformWith: '`@receiver radians' -> '`@receiver rads'.
	^ self rads
]

{ #category : #accessing }
GAngle >> rads [
	^ radians
]

{ #category : #arithmetic }
GAngle >> sin [
	^ self rads sin
]

{ #category : #arithmetic }
GAngle >> substractWithAngle: aGAngle [ 
	^ (aGAngle rads - self rads) rads
]

{ #category : #arithmetic }
GAngle >> tan [
	^ self rads tan
]
