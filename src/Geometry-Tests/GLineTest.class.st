Class {
	#name : #GLineTest,
	#superclass : #GElementTestCase,
	#instVars : [
		'line'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GLineTest >> actualClass [
	^ GLine
]

{ #category : #tests }
GLineTest >> testAngleWith [
	| line2 |
	line := GLine through: 0 , 0 and: 5 , 24.
	line2 := GLine through: 3 , 4 and: 4 , 7.
	self assert: (line angleWith: line2) equals: -0.11635 rads 
]

{ #category : #tests }
GLineTest >> testAsGLine [
	line := GLine through: 1 , 2 and: 3 , 5.
	self assert: line asGLine equals: line
]

{ #category : #tests }
GLineTest >> testDistanceTo [
	self assert: ((GLine a: 1 b: 0 c: -7) distanceTo: 7 , 0) equals: 0.
	self assert: ((GLine a: 1 b: 0 c: -7) distanceTo: 7 , 7) equals: 0.
	self assert: ((GLine a: 1 b: 0 c: -7) distanceTo: 0 , 0) equals: 7
]

{ #category : #tests }
GLineTest >> testEquals [
	self assert: (GLine a: 1 b: 1 c: -13) equals: (GLine a: 6 b: 6 c: -78).
	self assert: (GLine a: 1 b: 1 c: -13) hash equals: (GLine a: 1 b: 1 c: -13) hash.
	self assert: (GLine a: 0 b: 1 c: -13) equals: (GLine a: 0 b: 6 c: -78).
	self deny: (GLine a: 1 b: 1 c: -13) = (GLine a: 1 b: 6 c: -78).
	self deny: (GLine a: 1 b: 1 c: -13) = (GLine a: 6 b: 6 c: -7).
	self assert: (GLine a: 1 b: 0 c: -13) equals: (GLine a: 6 b: 0 c: -78).
	self assert: (GLine a: 0 b: 1 c: 0) equals: (GLine a: 0 b: 6 c: 0).
	self assert: (GLine a: 1 b: 0 c: 0) equals: (GLine a: 1 b: 0 c: 0).
	self deny: (GLine a: 1 b: 1 c: -13) = (GLine a: 6 b: 6 c: 0).
	self assert: (GLine a: 0 b: 1 c: -13) equals: (GLine a: 0 b: 6 c: -78).
	self assert: (GLine a: -48.989794855663575 b: 48.98979485566357 c: 4.547473508864641e-13) equals: (GLine a: -138.58803762173304 b: 138.58803762173304 c: 1.8189894035458565e-12).
	self
		assert: (GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178) asGLine
		equals: (GSegment with: -99.30232333601874 , -99.30232333601876 with: 39.285714285714285 , 39.28571428571428) asGLine.
	self
		assert: (GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178) asGLine
		equals: (GSegment with: 24.494897427831784 , 24.49489742783178 with: -24.494897427831784 , -24.494897427831795) asGLine
]

{ #category : #tests }
GLineTest >> testIncludes [
	self deny: ((GSegment with: 17674 / 229 , (14582 / 229) with: 76.82622578909061 , 64.97050543967634) asGLine includes: -28206 / 397 , (50382 / 397)).
	self assert: ((GLine through: 1 , 3 and: 3 , 0) includes: 1 , 3).
	self assert: ((GLine through: 1 , 3 and: 3 , 0) includes: 3 , 0).
	self assert: ((GLine through: -1 , 1 and: 1 , -1) includes: 0 , 0).
	self assert: ((GLine through: 0 , 0 and: 12 , 9) includes: 13 , (39 / 4)).
	self assert: ((GLine through: 0 , 0 and: 13 , (39 / 4)) includes: 12 , 9).
	self deny: ((GLine through: 0 , 0 and: 1 , 1) includes: 1 , 2).
	self deny: ((GLine through: 0 , 0 and: 1 , 1) includes: 1 , 1.01).
	self deny: ((GLine through: 0 , 0 and: 1 , 1) includes: 2 , 2.001)
]

{ #category : #tests }
GLineTest >> testIntersectionsWithArc [
	| arc |
	line := GLine through: 0 , 0 and: 1 , 1.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (line intersectionsWith: arc) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (line intersectionsWith: arc) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (line intersectionsWith: arc) hasSameElements: (line intersectionsWithArc: arc)
]

{ #category : #tests }
GLineTest >> testIntersectionsWithEllipse [
	| ellipse |
	"Test without intersection"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := (GLine a: -1 b: 1 c: -20).
	self assert: (line intersectionsWith: ellipse) isEmpty.
	
	"Test with an ellipse centered at the origin and a line going through the origin"
	ellipse := GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0.
	line := GLine a: -1 b: 1 c: 0.
	self assert: (line intersectionsWith: ellipse) hasCloseElementsTo: {(1.6641 , 1.6641) . (-1.6641 , -1.6641)}.

	"Test with an ellipse centered at the origin and a line not going through the origin"
	line := GLine a: -1 b: 1 c: -1.
	self assert: (line intersectionsWith: ellipse) hasCloseElementsTo: {(0.9065084 , 1.9065084) . (-2.291123 , -1.291123)}.

	"Test with an ellipse not centered at the origin and a line not going through the origin"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := GLine a: -2 b: 1 c: -8.
	self assert: (line intersectionsWith: ellipse) hasCloseElementsTo: {(-0.263181454 , 7.473637091) . (-1.873804847 , 4.252390306)}.
	self assertCollection: (line intersectionsWith: ellipse) hasSameElements: (line intersectionsWithEllipse: ellipse).
	
	"Test with tangent"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := GLine a: -1 b: 1 c: -8.
	self assert: (line intersectionsWith: ellipse) hasCloseElementsTo: {(-6 / 5 , (34 / 5))}
]

{ #category : #tests }
GLineTest >> testIntersectionsWithLine [
	| line2 |
	line := GLine through: 0 , 0 and: 1 , 1.
	line2 := GLine through: 3 , 3 and: 5 , 5.
	self assert: (line intersectionsWith: line2) isEmpty.

	line := GLine a: 2 b: -3 c: 0.5.
	line2 := GLine a: 1 b: 1 c: -2.
	self assert: (line intersectionsWith: line2) hasCloseElementsTo: {(1.1 , 0.9)}.

	line2 := GLine a: -2 b: -2 c: 4.
	self assert: (line intersectionsWith: line2) hasCloseElementsTo: {(1.1 , 0.9)}.
	self assertCollection: (line intersectionsWith: line2) hasSameElements: (line intersectionsWithLine: line2)
]

{ #category : #tests }
GLineTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	line := GLine through: 5 , 6 and: 7 , 102.
	self assert: (line intersectionsWith: point) isEmpty.

	line := GLine through: 1 , 3 and: 3 , 5.
	self assert: (line intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assertCollection: (line intersectionsWith: point) hasSameElements: (line intersectionsWithPoint: point)
]

{ #category : #tests }
GLineTest >> testIntersectionsWithPolygon [
	| polygon |
	line := GLine through: 0 , 1 and: 5 , 6.
	polygon := GPolygon vertices: {(3 , 3) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (line intersectionsWith: polygon) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (line intersectionsWith: polygon) hasCloseElementsTo: {(3 , 4) . (2 , 3)}.
	self assertCollection: (line intersectionsWith: polygon) hasSameElements: (line intersectionsWithPolygon: polygon).

	polygon := GPolygon vertices: {(2 , 3) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (line intersectionsWith: polygon) hasCloseElementsTo: {(2 , 3)}
]

{ #category : #tests }
GLineTest >> testIntersectionsWithRay [
	| ray |
	line := GLine through: -5 , 1 and: -3 , 3.	
	ray := GRay origin: -5 , 3  direction: -7, 5 .
	self assert: (line intersectionsWith: ray) isEmpty.
	
	ray := GRay origin: -7 , 5  direction: -5, 3 .
	self assert: (line intersectionsWith: ray) hasCloseElementsTo: {(-4 , 2)}.
	self assertCollection: (line intersectionsWith: ray) hasSameElements: (line intersectionsWithRay: ray)
]

{ #category : #tests }
GLineTest >> testIntersectionsWithSegment [
	| segment |
	line := GLine through: -5 , 1 and: -3 , 3.
	segment := GSegment with: -7 , 2  with: -4, 3 .
	self assert: (line intersectionsWith: segment) isEmpty.
	
	segment := GSegment with: -6 , 4  with: -3, 1 .
	self assert: (line intersectionsWith: segment) hasCloseElementsTo: {(-4 , 2)}.
	self assertCollection: (line intersectionsWith: segment) hasSameElements: (line intersectionsWithSegment: segment)
]

{ #category : #tests }
GLineTest >> testIsParallelTo [
	self deny: ((GLine a: 0 b: -3 c: 0.5) isParallelTo: (GLine a: -2 b: 0 c: 4)).
	self deny: ((GLine a: 0 b: -3 c: 0.5) isParallelTo: (GLine a: -2 b: 1 c: 4)).
	self assert: ((GLine a: 1 b: 2 c: 0.5) isParallelTo: (GLine a: 2 b: 4 c: 4)).
	self assert: ((GLine a: 0 b: 2 c: 0.5) isParallelTo: (GLine a: 0 b: 2 c: 0.5))
]

{ #category : #tests }
GLineTest >> testTranslateBy [
	line := GLine through: -1 , -4 and: 1 , -2.
	line translateBy: #(1 -2) asGVector.
	self assert: (line isParallelTo: (GLine through: -1 , -4 and: 1 , -2)).
	self assert: (line includes: 0 , -6).
	self assert: (line includes: 3 , -3).
	self assert: (line includes: -1 , -7)
]
