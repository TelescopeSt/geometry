"
A G1DElementTest is a test class for testing the behavior of G1DElement
"
Class {
	#name : #GArcTest,
	#superclass : #GElementTestCase,
	#instVars : [
		'arc'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GArcTest >> actualClass [
	^ GArc
]

{ #category : #test }
GArcTest >> testAngle [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc angle equals: 90 degrees
]

{ #category : #test }
GArcTest >> testCentralAngle [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc centralAngle equals: 90 degrees.
	self assert: arc centralAngle equals: arc angle.
]

{ #category : #test }
GArcTest >> testEndPoint [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc endPoint equals: 8 , 8
]

{ #category : #test }
GArcTest >> testEquals [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc equals: (GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10).
	self assert: arc hash equals: (GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10) hash.
	self assert: arc equals: (GArc center: 6 , 6 origin: 8 , 4 direction: 11 , 11).
	self assert: arc hash equals: (GArc center: 6 , 6 origin: 8 , 4 direction: 11 , 11) hash.
	
	self deny: arc = (GArc center: 5 , 6 origin: 8 , 4 direction: 11 , 11).
	self deny: arc hash = (GArc center: 5 , 6 origin: 8 , 4 direction: 11 , 11) hash.
	self deny: arc = (GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 11).
	self deny: arc hash = (GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 11) hash.
	
	arc := GArc center: 6 , 6 origin: 8 , 4 angle: 0.5π rads.
	self assert: arc equals: (GArc center: 6 , 6 origin: 8 , 4 angle: 0.5π rads).
	self assert: arc hash equals: (GArc center: 6 , 6 origin: 8 , 4 angle: 0.5π rads) hash.
]

{ #category : #test }
GArcTest >> testIncludes [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: (arc includes: 8.8284271247462 , 6).
	self deny: (arc includes: 8 , 6).
	self deny: (arc includes: 4 , 4).
	self deny: (arc includes: 4 , 8).
	
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 3, 6.
	self assert: (arc includes: 8.8284271247462 , 6).
	self deny: (arc includes: 8 , 6).
	self deny: (arc includes: 4 , 4).
	self assert: (arc includes: 4 , 8).
]

{ #category : #test }
GArcTest >> testIntersectionsWithArc [
	"Because we need the intersection between two ellipse to do that. Until we have that, we declare the test as expected failure"
	<expectedFailure>
	| arc2 |
	arc2 := GArc center: 1 , -1 origin: 5 , -1 direction: 5 , 0.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: -1 , 2.
	self assert: (arc intersectionsWith: arc2) isEmpty.


	arc2 := GArc center: 1 , -1 origin: 5 , -1 direction: 0 , 2.
	self assert: (arc intersectionsWith: arc2) hasCloseElementsTo: {(1 , 3)}.
	self assertCollection: (arc intersectionsWith: arc2) hasSameElements: (arc intersectionsWithArc: arc2)
]

{ #category : #test }
GArcTest >> testIntersectionsWithEllipse [
	"Because we need the intersection between two ellipse to do that. Until we have that, we declare the test as expected failure"
	<expectedFailure>
	| ellipse |
	ellipse := GEllipse center: -4 , 3 vertex: 1 , 3 coVertex: -4 , 7.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (arc intersectionsWith: ellipse) isEmpty.

	arc := GArc center: 1 , 0 origin: 4 , 0 direction: -1 , 2.
	self assert: (arc intersectionsWith: ellipse) hasCloseElementsTo: {(1 , 3)}.
	self assertCollection: (arc intersectionsWith: ellipse) hasSameElements: (arc intersectionsWithEllipse: ellipse)
]

{ #category : #test }
GArcTest >> testIntersectionsWithLine [
	| line |
	line := GLine through: 0 , 0 and: 1 , 1.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (arc intersectionsWith: line) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (arc intersectionsWith: line) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (arc intersectionsWith: line) hasSameElements: (arc intersectionsWithLine: line)
]

{ #category : #test }
GArcTest >> testIntersectionsWithPoint [
	| point |
	point := 3 , 3.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (arc intersectionsWith: point) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (arc intersectionsWith: point) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (arc intersectionsWith: point) hasSameElements: (arc intersectionsWithPoint: point)
]

{ #category : #test }
GArcTest >> testIntersectionsWithPolygon [
	| polygon |
	polygon := GPolygon vertices: {(1 , 2) . (1 , 5) . (-3 , 5) . (-3 , 0)}.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (arc intersectionsWith: polygon) isEmpty.

	arc := GArc center: 1 , 0 origin: 4 , 0 direction: -1 , 2.
	self assert: (arc intersectionsWith: polygon) hasCloseElementsTo: {(1 , 3)}.
	self assertCollection: (arc intersectionsWith: polygon) hasSameElements: (arc intersectionsWithPolygon: polygon)
]

{ #category : #test }
GArcTest >> testIntersectionsWithRay [
	| ray |
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (arc intersectionsWith: ray) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (arc intersectionsWith: ray flipped) isEmpty.

	self assert: (arc intersectionsWith: ray) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (arc intersectionsWith: ray) hasSameElements: (arc intersectionsWithRay: ray)
]

{ #category : #test }
GArcTest >> testIntersectionsWithSegment [
	| segment |
	segment := GSegment with: 0 , 0 with: 1 , 1.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (arc intersectionsWith: segment) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (arc intersectionsWith: segment) isEmpty.

	segment := GSegment with: 0 , 0 with: 4 , 4.
	self assert: (arc intersectionsWith: segment) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (arc intersectionsWith: segment) hasSameElements: (arc intersectionsWithSegment: segment)
]

{ #category : #test }
GArcTest >> testLength [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc length =~ 4.442882938158366
]

{ #category : #test }
GArcTest >> testRadius [
	arc := GArc center: 6 , 6 origin: 10 , 6 direction: 10 , 10.
	self assert: arc radius equals: 4
]

{ #category : #test }
GArcTest >> testTranslateBy [
	arc := GArc center: 6 , 6 origin: 10 , 6 direction: 10 , 10.
	arc translateBy: #(1 -2) asGVector.
	self assert: arc equals: (GArc center: 7 , 4 origin: 11 , 4 direction: 11 , 8)
]
