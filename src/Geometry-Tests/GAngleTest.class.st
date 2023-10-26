Class {
	#name : #GAngleTest,
	#superclass : #GTestCase,
	#instVars : [
		'angle'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GAngleTest >> actualClass [
	^ GAngle
]

{ #category : #tests }
GAngleTest >> testAddition [
	angle := 90 degrees.
	self assert: (angle + 10 degrees) equals: 100 degrees.
	self assert: (angle + 360 degrees) equals: 90 degrees.
	self should: [ angle + 10 ] raise: Error description: 'It should not be possible to add a number to an angle'.
]

{ #category : #tests }
GAngleTest >> testCos [
	angle := 90 degrees.
	self assert: angle cos =~ 0.
	
	angle := 180 degrees.
	self assert: angle cos =~ -1.
	
	angle := 270 degrees.
	self assert: angle cos =~ 0.
	
	angle := 0 degrees.
	self assert: angle cos =~ 1
]

{ #category : #tests }
GAngleTest >> testCreation [
	angle := 90 degrees.
	self assert: angle equals: (GAngle degrees: 90).

	angle := 1π rads.
	self assert: angle equals: (GAngle radians: 1π)
]

{ #category : #tests }
GAngleTest >> testDegreeNumber [
	angle := 90 degrees.
	self assert: angle degreeNumber equals: 90
]

{ #category : #tests }
GAngleTest >> testDivision [
	angle := 90 degrees.
	self assert: angle / 2 equals: 45 degrees.
	self assert: angle / 1 equals: 90 degrees.
	self should: [ angle / 10 degrees ] raise: Error description: 'It should not be possible to divide two angles'.
	self should: [ 10 / angle ] raise: Error description: 'It should not be possible to divide a number by an angle'.
]

{ #category : #tests }
GAngleTest >> testEquals [
	angle := 90 degrees.
	self assert: angle equals: 90 degrees.
	self assert: angle hash equals: 90 degrees hash.
	self deny: angle = 60 degrees.
	self deny: angle hash = 60 degrees hash.
	self assert: angle equals: 450 degrees.
	self assert: angle hash equals: 450 degrees hash.
	self assert: angle equals: -270 degrees.
	self assert: angle hash equals: -270 degrees hash.
	
	self assert: angle = 90.00000000000000000000000000000000000000000000000001 degrees description: 'We accept a little imprecision because of the float precision'
]

{ #category : #tests }
GAngleTest >> testExplementary [
	angle := 90 degrees.
	self assert: angle explementary equals: 270 degrees.
	
	angle := 80 degrees.
	self assert: angle explementary equals: 280 degrees
]

{ #category : #tests }
GAngleTest >> testInferior [
	angle := 90 degrees.
	self assert: angle < 100 degrees.
	self deny: angle < 90 degrees.
	self deny: angle < 80 degrees.
	self deny: angle < 400 degrees.
	self assert: angle < -260 degrees
]

{ #category : #tests }
GAngleTest >> testInferiorOrEqual [
	angle := 90 degrees.
	self assert: angle <= 100 degrees.
	self assert: angle <= 90 degrees.
	self deny: angle <= 80 degrees.
	self deny: angle <= 400 degrees.
	self assert: angle <= -260 degrees
]

{ #category : #tests }
GAngleTest >> testIsAcute [
	angle := 80 degrees.
	self assert: angle isAcute.
	
	angle := 100 degrees.
	self deny: angle isAcute.
	
	angle := 90 degrees.
	self deny: angle isAcute
]

{ #category : #tests }
GAngleTest >> testIsObtuse [
	angle := 80 degrees.
	self deny: angle isObtuse.
	
	angle := 100 degrees.
	self assert: angle isObtuse.
	
	angle := 190 degrees.
	self deny: angle isObtuse.
	
	angle := 90 degrees.
	self deny: angle isObtuse
]

{ #category : #tests }
GAngleTest >> testIsReflex [
	angle := 80 degrees.
	self deny: angle isReflex.
	
	angle := 180 degrees.
	self deny: angle isReflex.
	
	angle := 200 degrees.
	self assert: angle isReflex
]

{ #category : #tests }
GAngleTest >> testIsRight [
	angle := 80 degrees.
	self deny: angle isRight.
	
	angle := 100 degrees.
	self deny: angle isRight.
	
	angle := 90 degrees.
	self assert: angle isRight
]

{ #category : #tests }
GAngleTest >> testIsStraight [
	angle := 80 degrees.
	self deny: angle isStraight.
	
	angle := 180 degrees.
	self assert: angle isStraight.
	
	angle := 200 degrees.
	self deny: angle isStraight
]

{ #category : #tests }
GAngleTest >> testIsZero [
	angle := 0 degrees.
	self assert: angle isZero.

	angle := 90 degrees.
	self deny: angle isZero
]

{ #category : #tests }
GAngleTest >> testMultiplication [
	angle := 90 degrees.
	self assert: angle * 2 equals: 180 degrees.
	self assert: 2 * angle equals: 180 degrees.
	self assert: angle * 1 equals: 90 degrees.
	self should: [ angle * 10 degrees ] raise: GeometryError description: 'It should not be possible to multiple two angles'
]

{ #category : #tests }
GAngleTest >> testRads [
	angle := 90 degrees.
	self assert: angle rads equals: 0.5π
]

{ #category : #tests }
GAngleTest >> testSin [
	angle := 90 degrees.
	self assert: angle sin =~ 1.
	
	angle := 180 degrees.
	self assert: angle sin =~ 0.
	
	angle := 270 degrees.
	self assert: angle sin =~ -1.
	
	angle := 0 degrees.
	self assert: angle sin =~ 0
]

{ #category : #tests }
GAngleTest >> testSubtraction [
	angle := 90 degrees.
	self assert: (angle - 10 degrees) equals: 80 degrees.
	self assert: (angle - 360 degrees) equals: 90 degrees.
	self should: [ angle - 10 ] raise: Error description: 'It should not be possible to substract a number to an angle'.
]

{ #category : #tests }
GAngleTest >> testSuperior [
	angle := 90 degrees.
	self deny: angle > 100 degrees.
	self deny: angle > 90 degrees.
	self assert: angle > 80 degrees.
	self assert: angle > 400 degrees.
	self deny: angle > -260 degrees
]

{ #category : #tests }
GAngleTest >> testSuperiorOrEqual [
	angle := 90 degrees.
	self deny: angle >= 100 degrees.
	self assert: angle >= 90 degrees.
	self assert: angle >= 80 degrees.
	self assert: angle >= 400 degrees.
	self deny: angle >= -260 degrees
]

{ #category : #tests }
GAngleTest >> testTan [	
	angle := 180 degrees.
	self assert: angle tan =~ 0.
	
	angle := 0 degrees.
	self assert: angle tan =~ 0
]
