Class {
	#name : #GVectorTest,
	#superclass : #GTestCase,
	#instVars : [
		'vector'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GVectorTest >> actualClass [
	^ GVector
]

{ #category : #tests }
GVectorTest >> test2DVector [
	vector := GVector x: 1 y: 2.
	self assert: vector x equals: 1.
	self assert: vector y equals: 2.
	
	vector := GVector x: -1 y: -2.
	self assert: vector x equals: -1.
	self assert: vector y equals: -2.
	
	vector := GVector coordinates: (G2DCoordinates x: 1 y: 2).
	self assert: vector x equals: 1.
	self assert: vector y equals: 2
]

{ #category : #tests }
GVectorTest >> testAngleWith [
	vector := {2 . 0} asGVector.
	self assert: (vector angleWith: vector) isZero.
	self assert: (vector angleWith: {2 . 1} asGVector) equals: 0.4636476090008063 rads.
	self assert: ({2 . 1} asGVector angleWith: vector) equals: -0.4636476090008063 rads.
	self assert: (vector angleWith: {2 . 2} asGVector) equals: 0.7853981633974483 rads.
	self assert: ({2 . 2} asGVector angleWith: vector) equals: -0.7853981633974483 rads.
	self assert: (vector angleWith: {1 . 2} asGVector) equals: 1.1071487177940922 rads.
	self assert: ({1 . 2} asGVector angleWith: vector) equals: -1.1071487177940922 rads
]

{ #category : #tests }
GVectorTest >> testDotProduct [
	vector := {-6 . 8} asGVector.
	self assert: (vector dotProduct: {5 . 12} asGVector) equals: 66
]

{ #category : #tests }
GVectorTest >> testEquals [
	self flag: #pharo6. "Use #deny:equals: when Pharo 7 will be the minimum requirement"
	self assert: (GVector x: 1 y: 2) equals: (GVector x: 1 y: 2).
	self deny: (GVector x: 2 y: 4) = (GVector x: 1 y: 2).
	self assert: (GVector x: 1 y: 2) hash equals: (GVector x: 1 y: 2) hash.
	self deny: (GVector x: 2 y: 4) hash = (GVector x: 1 y: 2) hash
]

{ #category : #tests }
GVectorTest >> testLength [
	vector := GVector x: 3 y: -4.
	self assert: vector length equals: 5
]

{ #category : #tests }
GVectorTest >> testMultiplication [
	| newVector |
	vector := #(2 8) asGVector.
	newVector := vector * 2.
	self assert: newVector x equals: 4.
	self assert: newVector y equals: 16
]

{ #category : #tests }
GVectorTest >> testNonOrientedAngleWith [
	vector := {2 . 9 . -3} asGVector.
	self assert: (vector nonOrientedAngleWith: {-3 . -4 . 8} asGVector) equals: 2.37687 rads.

	vector := {5 . 24} asGVector.
	self assert: (vector nonOrientedAngleWith: {1 . 3} asGVector) equals: 0.11635 rads.

	vector := {2 . 0} asGVector.
	self assert: (vector nonOrientedAngleWith: vector) isZero.
	self assert: (vector nonOrientedAngleWith: {2 . 1} asGVector) equals: 0.4636476090008063 rads.
	self assert: ({2 . 1} asGVector nonOrientedAngleWith: vector) equals: 0.4636476090008063 rads.
	self assert: (vector nonOrientedAngleWith: {2 . 2} asGVector) equals: 0.7853981633974483 rads.
	self assert: ({2 . 2} asGVector nonOrientedAngleWith: vector) equals: 0.7853981633974483 rads.
	self assert: (vector nonOrientedAngleWith: {1 . 2} asGVector) equals: 1.1071487177940922 rads.
	self assert: ({1 . 2} asGVector nonOrientedAngleWith: vector) equals: 1.1071487177940922 rads
]
