"
Description
--------------------

I represent a geometric vector. I have a state close to the state of a GPoint but a vector only represent a direction and a length.

My direction will go from the origin of the plan ( (0, 0) in a 2D plan) to my coordinates. My length will be defined by my coordinates.

Examples
--------------------

	""Instance creation""
	GVector withCollection: #(1 2).	 ""a GVector(1,2)""
	
	GVector coordinates: (GCoordinates withCollection: #(1 3)). 	""a GVector(1,3)""
	
	(GCoordinates withCollection: #(1 3)) asGVector.	""a GVector(1,3)""
	
	#(1 2) asGVector.	""a GVector(1,2)""	
			
	""Arithmetic""	
	#(3 5) asGVector length.	""5.830951894845301""
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	coordinates:		<GCoordinates> 	Coordinates defining my direction and length.

"
Class {
	#name : #GVector,
	#superclass : #GeometryObject,
	#traits : 'TGWithCoordinates',
	#classTraits : 'TGWithCoordinates classTrait',
	#instVars : [
		'coordinates'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GVector class >> coordinates: aCoordinates [
	(aCoordinates coordinates allSatisfy: [ :e | e = 0]) ifTrue: [ ^ GZeroVector coordinates: aCoordinates ].

	^ self new
		coordinates: aCoordinates;
		yourself
]

{ #category : #'instance creation' }
GVector class >> withCollection: aCollection [
	^ self coordinates: (GCoordinates withCollection: aCollection)
]

{ #category : #'instance creation' }
GVector class >> x: aNumber y: anotherNumber [
	^ self coordinates: (G2DCoordinates x: aNumber y: anotherNumber)
]

{ #category : #arithmetic }
GVector >> * anOperand [
	^ anOperand multiplyWithVector: self
]

{ #category : #arithmetic }
GVector >> + anOperand [
	^ anOperand additionWithVector: self
]

{ #category : #arithmetic }
GVector >> / aGVector [ 
	self shouldBeImplemented.
]

{ #category : #comparing }
GVector >> = anotherPoint [
	"Answer whether the receiver and anObject represent the same object."

	self == anotherPoint ifTrue: [ ^ true ].
	self class = anotherPoint class ifFalse: [ ^ false ].

	^ coordinates = anotherPoint coordinates
]

{ #category : #arithmetic }
GVector >> adaptToNumber: anInteger andSend: aString [ 
	^ self perform: aString with: anInteger
]

{ #category : #arithmetic }
GVector >> additionWithVector: aGVector [
	^ (self coordinates + aGVector coordinates) asGVector
]

{ #category : #arithmetic }
GVector >> angleWith: aGVector [
	| angle |
	self flag: #todo.	"This implementation is only for 2D vectors. Later we should support it for n-dimension vectors."
	self coordinates numberOfDimensions ~= 2 ifTrue: [ self error: 'For now oriented angle is only implemented for 2D vectors. Feel free to contribute.' ]. 
	
	angle := self nonOrientedAngleWith: aGVector.

	^ (GMatrix rows: {self coordinates . aGVector coordinates}) determinant > 0 ifTrue: [ angle ] ifFalse: [ angle explementary ]
]

{ #category : #accessing }
GVector >> coordinates [
	^ coordinates
]

{ #category : #accessing }
GVector >> coordinates: anObject [
	coordinates := anObject
]

{ #category : #arithmetic }
GVector >> dotProduct: aGVector [
	^ (self coordinatesWith: aGVector coordinates collect: [ :point1 :point2 | point1 * point2 ]) sum
]

{ #category : #comparing }
GVector >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	| coordHash |
	coordHash := coordinates hash.
	^ coordHash squared + coordHash "Try to avoid collisions with GAbstractCoordinates and GPoint"
]

{ #category : #testing }
GVector >> isZeroVector [
	^ false
]

{ #category : #accessing }
GVector >> length [
	"https://onlinemschool.com/math/library/vector/length/"

	^ (self coordinates inject: 0 into: [ :res :number | res + number squared ]) sqrt
]

{ #category : #arithmetic }
GVector >> multiplyWithVector: aGVector [
	"We should implement vector product later."
	
	self shouldBeImplemented
]

{ #category : #arithmetic }
GVector >> nonOrientedAngleWith: aGVector [
	"angle = cos^-1 a . b / (|a| * |b|)"

	"If we have a zero vector, delegate it the computation to avoid a zero divide."

	aGVector isZeroVector ifTrue: [ ^ aGVector angleWith: self ].

	^ ([ ((self dotProduct: aGVector) / (self length * aGVector length)) arcCos ]
		on: DomainError
		do:
			[ "Sometimes we can get a Domain Error because of some missprecision of floats... In that case we will reduce the precision to get a result" ((self dotProduct: aGVector) / (self length * aGVector length) roundTo: 0.00000000000001) arcCos ]) rads
]
