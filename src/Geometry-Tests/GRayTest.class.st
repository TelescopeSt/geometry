Class {
	#name : #GRayTest,
	#superclass : #GElementTestCase,
	#instVars : [
		'ray'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GRayTest >> actualClass [
	^ GRay
]

{ #category : #tests }
GRayTest >> testAngleWith [
	| ray2 |
	ray := GRay origin: 0 , 0 direction: 5 , 24.
	ray2 := GRay origin: 3 , 4 direction: 4 , 7.
	self assert: (ray angleWith: ray2) equals: -0.11635 rads
]

{ #category : #tests }
GRayTest >> testEquals [
	| ray2 |
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	ray2 := GRay origin: 0 , 0 direction: 2 , 2.
	self assert: ray equals: ray2.
	self assert: ray hash equals: ray2 hash.

	ray2 := GRay origin: 0,0 direction: 2, 3.
	self deny: ray = ray2.
	self deny: ray hash = ray2 hash
]

{ #category : #tests }
GRayTest >> testFlipped [
	self assert: (GRay origin: 100 , 100 direction: 80 , 110) flipped directionPoint equals: 120 , 90.
	self assert: (GRay origin: 100 , 100 direction: 120 , 90) flipped directionPoint equals: 80 , 110
]

{ #category : #tests }
GRayTest >> testIncludes [
	self deny: ((GRay origin: 100 , 100 direction: 80 , 110) includes: 120 , 90).
	self assert: ((GRay origin: 100 , 100 direction: 120 , 90) includes: 120 , 90).
	self assert: ((GRay origin: 100 , 100 direction: 120 , 90) includes: 100 , 100).
	self assert: ((GRay origin: 100 , 100 direction: 110 , 110) includes: 150 , 150).
	self assert: ((GRay origin: 0 , 0 direction: 12 , 9) includes: 13 , (39 / 4)).
	self assert: ((GRay origin: 28 , 30 direction: 9 , 1) includes: -4.97992 , -20.33777)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithArc [
	| arc |
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (ray intersectionsWith: arc) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (ray flipped intersectionsWith: arc) isEmpty.

	self assert: (ray intersectionsWith: arc) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (ray intersectionsWith: arc) hasSameElements: (ray intersectionsWithArc: arc)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithEllipse [
	| ellipse |
	ray := GRay origin: 0 , -1 direction: 1 , 4.
	ellipse := GEllipse center: 3.5 , 2 vertex: 6 , 2 coVertex: 3.5 , 4.
	self assert: (ray intersectionsWith: ellipse) isEmpty.

	ray := GRay origin: 2 , 3 direction: 0 , 1.
	self assert: (ray intersectionsWith: ellipse) hasCloseElementsTo: {(1 , 2)}.

	ray := GRay origin: 0 , 1 direction: 5 , 6.
	self assert: (ray intersectionsWith: ellipse) hasCloseElementsTo: {(1 , 2) . (2.951219 , 3.951219)}.
	self assertCollection: (ray intersectionsWith: ellipse) hasSameElements: (ray intersectionsWithEllipse: ellipse)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithLine [
	| line |
	line := GLine through: -5 , 1 and: -3 , 3.	
	ray := GRay origin: -5 , 3  direction: -7, 5 .
	self assert: (ray intersectionsWith: line) isEmpty.
	
	ray := GRay origin: -7 , 5  direction: -5, 3 .
	self assert: (ray intersectionsWith: line) hasCloseElementsTo: {(-4 , 2)}.
	self assertCollection: (ray intersectionsWith: line) hasSameElements: (ray intersectionsWithLine: line)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	ray := GRay origin: 5 , 6 direction: 7 , 102.
	self assert: (ray intersectionsWith: point) isEmpty.

	ray := GRay origin: 1 , 3 direction: 0 , 2.
	self assert: (ray intersectionsWith: point) isEmpty.

	ray := GRay origin: 0 , 2 direction: 1 , 3.
	self assert: (ray intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.

	ray := GRay origin: 1 , 3 direction: 3 , 5.
	self assert: (ray intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assertCollection: (ray intersectionsWith: point) hasSameElements: (ray intersectionsWithPoint: point)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithPolygon [
	| polygon |
	ray := GRay origin: 0 , -1 direction: 0 , 4.
	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (ray intersectionsWith: polygon) isEmpty.

	ray := GRay origin: 1 , 3 direction: 0 , -1.
	self assert: (ray intersectionsWith: polygon) isEmpty.

	ray := GRay origin: 0 , 1 direction: 5 , 6.
	self assert: (ray intersectionsWith: polygon) hasCloseElementsTo: {(2 , 3) . (3 , 4)}.
	self assertCollection: (ray intersectionsWith: polygon) hasSameElements: (ray intersectionsWithPolygon: polygon)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithRay [
	| ray2 |
	ray2 := GRay origin: -2 , 0 direction: -2 , 3.
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	self assert: (ray2 intersectionsWithRay: ray) isEmpty.

	ray2 := GRay origin: 2 , 3 direction: 2 , 0.
	self assert: (ray2 intersectionsWith: ray) hasCloseElementsTo: {(2 , 2)}.
	self assertCollection: (ray2 intersectionsWith: ray) hasSameElements: (ray2 intersectionsWithRay: ray).

	ray := GRay origin: 1 , 1 direction: 0 , 0.
	self assert: (ray2 intersectionsWith: ray) isEmpty
]

{ #category : #tests }
GRayTest >> testIntersectionsWithSegment [
	| segment |
	segment := GSegment with: -2 , 0 with: -2 , 3.
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	self assert: (ray intersectionsWith: segment) isEmpty.

	segment := GSegment with: 2 , 0 with: 2 , 3.
	self assert: (ray intersectionsWith: segment) hasCloseElementsTo: {(2 , 2)}.
	self assertCollection: (ray intersectionsWith: segment) hasSameElements: (ray intersectionsWithSegment: segment).

	ray := GRay origin: 1 , 1 direction: 0 , 0.
	self assert: (ray intersectionsWith: segment) isEmpty
]

{ #category : #tests }
GRayTest >> testTranslateBy [
	ray := GRay origin: -1 , -4 direction: 1 , -2.
	ray translateBy: #(1 -2) asGVector.
	self assert: ray initialPoint equals: 0 , -6
]
