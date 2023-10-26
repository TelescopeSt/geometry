"
Description
--------------------

	I represent the zero vector that is a vector of length 0 and the only vector without direction.
"
Class {
	#name : #GZeroVector,
	#superclass : #GVector,
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GZeroVector class >> coordinates: aCoordinates [
	^ self new
		coordinates: aCoordinates;
		yourself
]

{ #category : #arithmetic }
GZeroVector >> angleWith: aGVector [
	^ 0 rads
]

{ #category : #testing }
GZeroVector >> isZeroVector [
	^ true
]
