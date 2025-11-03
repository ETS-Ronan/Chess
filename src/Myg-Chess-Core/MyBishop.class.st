Class {
	#name : 'MyBishop',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBishop >> id [
	
	^ 'B'
]

{ #category : 'rendering' }
MyBishop >> renderPieceOn: aSquare [

	^ aSquare renderBishop: self
]

{ #category : 'rendering' }
MyBishop >> targetSquaresLegal: aBoolean [

| selectors targets |
	selectors := #(
		upRightDiagonalLegal:
		upLeftDiagonalLegal:
		downRightDiagonalLegal:
		downLeftDiagonalLegal:
	).
	targets := OrderedCollection new.
	selectors do: [ :sel | targets addAll: (self perform: sel with: aBoolean) ].
	^ targets
]

{ #category : 'evaluating' }
MyBishop >> value [
    ^ 3

]
