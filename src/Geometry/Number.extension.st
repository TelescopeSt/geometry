Extension { #name : #Number }

{ #category : #'*Geometry' }
Number >> , aNumber [
	^ GPoint x: self y: aNumber
]

{ #category : #'*Geometry' }
Number >> =~ aNumber [ 
	^((self - aNumber) abs) < Number epsilon.
]

{ #category : #'*Geometry' }
Number >> degrees [
	^ GAngle degrees: self
]

{ #category : #'*Geometry' }
Number >> divideWithAngle: aGAngle [

	^ (aGAngle rads / self) rads
]

{ #category : #'*Geometry' }
Number class >> epsilon [
	^ 0.00001
]

{ #category : #'*Geometry' }
Number >> multiplyWithAngle: aGAngle [

	^ (aGAngle rads * self) rads
]

{ #category : #'*Geometry' }
Number >> multiplyWithVector: aGVector [ 
	^ (aGVector coordinates * self) asGVector
]

{ #category : #'*Geometry' }
Number >> rads [
	^ GAngle radians: self
]

{ #category : #'*Geometry' }
Number >> π [
	^ self * Float pi
]
