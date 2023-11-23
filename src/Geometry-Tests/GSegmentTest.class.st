Class {
	#name : #GSegmentTest,
	#superclass : #GElementTestCase,
	#instVars : [
		'segment'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GSegmentTest >> actualClass [
	^ GSegment
]

{ #category : #tests }
GSegmentTest >> testAngleWith [
	| segment2 |
	segment := GSegment with: 0 , 0 with: 5 , 24.
	segment2 := GSegment with: 3 , 4 with: 4 , 7.
	self assert: (segment angleWith: segment2) equals: -0.11635 rads
]

{ #category : #tests }
GSegmentTest >> testAsGLine [
	| line |
	line := (GSegment with: 1 , 3 with: 3 , 0) asGLine.
	self assert: line a equals: 3.
	self assert: line b equals: 2.
	self assert: line c equals: -9.
	
	line := (GSegment with: -2 , 4 with: 2 , 4) asGLine.
	self assert: line a equals: 0.
	self assert: line b equals: 1.
	self assert: line c equals: -4.
	
	line := (GSegment with: 1 , 3 with: 1 , 0) asGLine.
	self assert: line a equals: 1.
	self assert: line b equals: 0.
	self assert: line c equals: -1
]

{ #category : #tests }
GSegmentTest >> testDistanceTo [
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) distanceTo: -2 , 4) equals: 0.
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) distanceTo: 2 , 4) equals: 0.
	self assert: ((GSegment with: 477 / 11 , (149 / 2) with: -56.73661227723915 , 143.3189209406019) distanceTo: 36819 / 1022 , (82249 / 1022)) =~ 0.7697676365059569.
	self assert: ((GSegment with: 838 / 41 , (4811 / 82) with: 57583 / 914 , (56095 / 914)) distanceTo: 57.998905906959145 , 61.11074842728413) =~ (2 * 0.02757564283371476)
]

{ #category : #tests }
GSegmentTest >> testEquals [
	| segm1 segm2 |
	self flag: #pharo6. "Use #deny:equals: when Pharo 7 will be the minimum requirement"
	segm1 := GSegment with: 1 , 2 with: 3 , 4.
	segm2 := GSegment with: 0 , 0 with: 3 , 3.
	self deny: segm1 = segm2.
	self deny: segm1 asGLine = segm2 asGLine.
	self deny: segm1 hash = segm2 hash.
	
	segm1 := GSegment with: 1 , 1 with: 3 , 3.
	segm2 := GSegment with: 0 , 0 with: 3 , 3.
	self assert: segm1 asGLine equals: segm2 asGLine.
	self deny: segm1 = segm2.
	
	segm1 := GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178.
	segm2 := GSegment with: 24.494897427831784 , 24.49489742783178 with: -24.494897427831784 , -24.494897427831795.
	self assert: segm1 asGLine equals: segm2 asGLine .
	
	segm1 := GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178.
	segm2 := GSegment with: 24.494897427831784 , 24.49489742783178 with: -24.494897427831784 , -24.494897427831795.
	self assert: segm1 equals: segm2.
	self assert: segm1 hash equals: segm2 hash.
	
	self assert: (GSegment with: -1 , -1 with: 1 , 1) equals: (GSegment with: 1 , 1 with: -1 , -1).
	self deny: (GSegment with: -1 , -1 with: 1 , 1) = (GSegment with: -1 , 1 with: -1 , 1).
]

{ #category : #tests }
GSegmentTest >> testIncludes [
	self assert: ((GSegment with: 1 , 3 with: 3 , 0) includes: 1 , 3).
	self assert: ((GSegment with: 1 , 3 with: 3 , 0) includes: 3 , 0).
	self assert: ((GSegment with: -1 , 1 with: 1 , -1) includes: 0 , 0).
	self deny: ((GSegment with: 0 , 0 with: 12 , 9) includes: 13 , (39 / 4)).
	self assert: ((GSegment with: 0 , 0 with: 13 , (39 / 4)) includes: 12 , 9)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithArc [
	| arc |
	segment := GSegment with: 0 , 0 with: 1 , 1.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (segment intersectionsWith: arc) isEmpty.

	arc := GArc center: -1 , 0 origin: 4 , 0 direction: 1 , 4.
	self assert: (segment intersectionsWith: arc) isEmpty.

	segment := GSegment with: 0 , 0 with: 4 , 4.
	self assert: (segment intersectionsWith: arc) hasCloseElementsTo: {(3 , 3)}.
	self assertCollection: (segment intersectionsWith: arc) hasSameElements: (segment intersectionsWithArc: arc)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithEllipse [
	| ellipse |
	segment := GSegment with: 0 , -1 with: 1 , 4.
	ellipse := GEllipse center: 3.5 , 2 vertex: 6 , 2 coVertex: 3.5 , 4.
	self assert: (segment intersectionsWith: ellipse) isEmpty.

	segment := GSegment with: 0 , 1 with: 2 , 3.
	self assert: (segment intersectionsWith: ellipse) hasCloseElementsTo: {(1 , 2)}.

	segment := GSegment with: 0 , 1 with: 5 , 6.
	self assert: (segment intersectionsWith: ellipse) hasCloseElementsTo: {(1 , 2) . (2.951219 , 3.951219)}.
	self assertCollection: (segment intersectionsWith: ellipse) hasSameElements: (segment intersectionsWithEllipse: ellipse)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithLine [
	| line |
	line := GLine through: -5 , 1 and: -3 , 3.
	segment := GSegment with: -7 , 2  with: -4, 3 .
	self assert: (segment intersectionsWith: line) isEmpty.
	
	segment := GSegment with: -6 , 4  with: -3, 1 .
	self assert: (segment intersectionsWith: line) hasCloseElementsTo: {(-4 , 2)}.
	self assertCollection: (segment intersectionsWith: line) hasSameElements: (segment intersectionsWithLine: line)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	segment := GSegment with: 5 , 6 with: 7 , 102.
	self assert: (segment intersectionsWith: point) isEmpty.

	segment := GSegment with: 1 , 3 with: 0 , 2.
	self assert: (segment intersectionsWith: point) isEmpty.

	segment := GSegment with: 1 , 3 with: 3 , 5.
	self assert: (segment intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assertCollection: (segment intersectionsWith: point) hasSameElements: (segment intersectionsWithPoint: point)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithPolygon [
	| polygon |
	segment := GSegment with: 0 , -1 with: 0 , 4.
	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (segment intersectionsWith: polygon) isEmpty.

	segment := GSegment with: 0 , -1 with: 1 , 3.
	self assert: (segment intersectionsWith: polygon) isEmpty.

	segment := GSegment with: 0 , 1 with: 5 , 6.
	self assert: (segment intersectionsWith: polygon) hasCloseElementsTo: {(2 , 3) . (3 , 4)}.
	self assertCollection: (segment intersectionsWith: polygon) hasSameElements: (segment intersectionsWithPolygon: polygon)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithRay [
	| ray |
	segment := GSegment with: -2 , 0 with: -2 , 3.
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	self assert: (segment intersectionsWithRay: ray) isEmpty.

	segment := GSegment with: 2 , 0 with: 2 , 3.
	self assert: (segment intersectionsWith: ray) hasCloseElementsTo: {(2 , 2)}.
	self assertCollection: (segment intersectionsWith: ray) hasSameElements: (segment intersectionsWithRay: ray).

	ray := GRay origin: 1 , 1 direction: 0 , 0.
	self assert: (segment intersectionsWith: ray) isEmpty
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithSegment [
	| segment2 |
	segment := GSegment with: -1 , -1 with: 1 , 1.
	segment2 := GSegment with: -3 , 3 with: -1 , 1.
	self assert: (segment intersectionsWith: segment2) isEmpty.

	segment := GSegment with: -3 , 1 with: -4 , 0.
	self assert: (segment intersectionsWith: segment2) isEmpty.

	segment := GSegment with: 0 , 1 with: 3 , 1.
	segment2 := GSegment with: 0 , 3 with: 4 , -1.
	self assert: (segment intersectionsWith: segment2) hasCloseElementsTo: {(2 , 1)}.
	self assertCollection: (segment intersectionsWith: segment2) hasSameElements: (segment intersectionsWithSegment: segment2).

	segment2 := GSegment with: 0 , 1 with: 2 , 8.
	self assert: (segment intersectionsWith: segment2) hasCloseElementsTo: {(0 , 1)}
]

{ #category : #tests }
GSegmentTest >> testLength [
	self assert: (GSegment with: 0 , 0 with: 3 , 4) length equals: 5.
	self assert: (GSegment with: -2 , 1 with: 3 , 4) length equals: 34 sqrt
]

{ #category : #tests }
GSegmentTest >> testMidPoint [
	self assert: (GSegment with: -1 , 2 with: 2 , 1) midPoint equals: 0.5 , 1.5.
	self assert: (GSegment with: 2 , 1 with: 2 , 1) midPoint equals: 2 , 1
]

{ #category : #tests }
GSegmentTest >> testPerpendicularBisector [
	self assert: (GSegment with: -1 , 2 with: 0 , 0) perpendicularBisector equals: (GLine a: -1 b: 2 c: -2.5).
	self assert: (GSegment with: 1 , 3 with: -1 , 1) perpendicularBisector equals: (GLine a: -2 b: -2 c: 4).
	self assert: (GSegment with: 3 , 0 with: 1 , 3) perpendicularBisector equals: (GLine a: -2 b: 3 c: -1 / 2)
]

{ #category : #tests }
GSegmentTest >> testSegmentFromPoints [
	self assert: (1 , 2 segment: 2 , 3) equals: (GSegment with: 1 , 2 with: 2 , 3)
]

{ #category : #tests }
GSegmentTest >> testTranslateBy [
	segment := GSegment with: -1 , -4 with: 1 , -2.
	segment translateBy: #(1 -2) asGVector.
	self assert: segment v1 equals: 0 , -6.
	self assert: segment v2 equals: 2 , -4
]
