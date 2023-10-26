"
Description
--------------------

In Euclidean geometry, an arc is a closed segment of a differentiable curve.

It is defined by 3 parameters
- The center of the arc
- The origin of the arc
- The oriented angle of the arc

Examples
--------------------

	GArc center: 3 , 3 origin: 5 , 6 angle: 0.5π radians.
	
	GArc center: 3 , 3 origin: 5 , 6 angle: 90 degrees.
	
	GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	
	(GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10) endPoint.
	
	(GArc center: 1 , 0 origin: 4 , 0 direction: -1 , 2) includes: 1 , 3.
	
	(GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4) intersectionsWith: (GLine through: 0 , 0 and: 1 , 1).
	
	(GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10) length.
	
	(GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10) radius.
	
	(GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10) translateBy: #(1 -2) asGVector.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	center:			<aGPoint>		Center of the circle whose bounds contains the arc.
	direction:		<aGPoint>		Origin point of the arc.
	angle:				<aGAngle>		Angle betweent the vector center-origin and the vector center-endpoint of the arc.

"
Class {
	#name : #GArc,
	#superclass : #G1DElement,
	#instVars : [
		'center',
		'origin',
		'angle'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GArc class >> center: aGPoint origin: anotherGPoint angle: aGAngle [
	"Take three parameters to create a new arc:
	- A point representing the center of the arc (center of the circle whose bond contains the arc circle)
	- A point defining the origin of the arc
	- An angle representing the angle between the vector center-origin and the vector center-endpoint of the arc."

	^ self new
		center: aGPoint;
		origin: anotherGPoint;
		angle: aGAngle;
		yourself
]

{ #category : #'instance creation' }
GArc class >> center: aGPoint origin: anotherGPoint direction: yetAnotherGPoint [
	"Take three parameters to create a new arc:
	- A point representing the center of the arc (center of the circle whose bond contains the arc circle)
	- A point defining the origin of the arc
	- A point denining the direction of the arc in the trigonometric direction"
	
	"The conventional representation of an arc it a center, an origin and an angle. To determine the angle we compute the oriented angle between the vector center-origin and the vector center-direction."
	^ self center: aGPoint origin: anotherGPoint angle: (aGPoint - anotherGPoint angleWith: aGPoint - yetAnotherGPoint)
]

{ #category : #comparing }
GArc >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ origin = anObject origin and: [ center = anObject center and: [ angle = anObject angle ] ]
]

{ #category : #accessing }
GArc >> angle [
	^ angle
]

{ #category : #accessing }
GArc >> angle: anObject [
	angle := anObject
]

{ #category : #accessing }
GArc >> center [
	^ center
]

{ #category : #accessing }
GArc >> center: anObject [
	center := anObject
]

{ #category : #accessing }
GArc >> centralAngle [
	"Alias of angle to cover the geometric names"

	^ self angle
]

{ #category : #accessing }
GArc >> endPoint [
	"The end point is the point at the end of the arc (opposed to the origin)."

	^ self origin rotatedBy: self angle about: self center
]

{ #category : #comparing }
GArc >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ origin hash bitXor: (center hash bitXor: angle hash)
]

{ #category : #testing }
GArc >> includes: aGPoint [
	"An arc includes a point in the angle between the vector defined by the origin and center and the vector defined by the point and the center is between 0 and the arc angle and if the distance of the point from the center is equals to the radius."

	^ ((self origin - self center angleWith: aGPoint - self center) < self angle)
		and: [ (aGPoint distanceTo: self center) =~ self radius ]
]

{ #category : #intersections }
GArc >> intersectionsWith: anElement [
	^ anElement intersectionsWithArc: self
]

{ #category : #intersections }
GArc >> intersectionsWithEllipse: aGEllipse [
	^ aGEllipse intersectionsWithArc: self
]

{ #category : #intersections }
GArc >> intersectionsWithLine: aGLine [ 
	^ aGLine intersectionsWithArc: self
]

{ #category : #accessing }
GArc >> length [
	^ self angle rads * self radius
]

{ #category : #accessing }
GArc >> origin [
	^ origin
]

{ #category : #accessing }
GArc >> origin: anObject [
	origin := anObject
]

{ #category : #comparing }
GArc >> printOn: aStream [
	super printOn: aStream.

	aStream
		<< $(;
		<< 'center: ';
		print: center coordinates;
		<< ' | origin: ';
		print: origin coordinates;
		<< ' | angle: ';
		print: self angle;
		<< $)
]

{ #category : #accessing }
GArc >> radius [
	^ (self origin - self center) length
]

{ #category : #comparing }
GArc >> translateBy: aGVector [ 
	self center: self center + aGVector.
	self origin: self origin + aGVector
]
