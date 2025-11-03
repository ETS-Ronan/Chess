Class {
	#name : 'MyKing',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyKing >> attackingSquares [

	^ self basicTargetSquares
]

{ #category : 'rendering' }
MyKing >> basicTargetSquares [

	"The king can move one square on each direction including diagonals"
	^ {
		square ifNotNil: #right.
		square up ifNotNil: #right.
		square ifNotNil: #up.
		square up ifNotNil: #left.
		square ifNotNil: #left.
		square left ifNotNil: #down.
		square ifNotNil: #down.
		square down ifNotNil: #right
	}
]

{ #category : 'accessing' }
MyKing >> id [
	
	^ 'K'
]

{ #category : 'testing' }
MyKing >> isCheckMated [
	^ self legalTargetSquares isEmpty
		and: [ (self threatenedSquares) includes: self square ]

]

{ #category : 'testing' }
MyKing >> isInCheck [
	^ (self threatenedSquares) includes: self square

]

{ #category : 'testing' }
MyKing >> isKing [
	
	^ true
]

{ #category : 'tests' }
MyKing >> opponentPieces [ ^ { Smalltalk globals at: #__foe }
]

{ #category : 'rendering' }
MyKing >> renderPieceOn: aSquare [

	^ aSquare renderKing: self
]

{ #category : 'rendering' }
MyKing >> targetSquaresLegal: aBoolean [
	"The king cannot move to threatened squares"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e | e attackingSquares ].
	^ self basicTargetSquares select: [ :s |
		s notNil and: [
			(threatenedSquares includes: s) not and: [
				s hasPiece not or: [ s contents color ~= color ] ] ] ]
]

{ #category : 'as yet unclassified' }
MyKing >> threatenedSquares [
	"Renvoie toutes les cases attaquées par les pièces adverses."
	^ (self opponentPieces flatCollect: [ :p | p attackingSquares ]) asSet

]

{ #category : 'testing' }
MyKing >> value [
    ^ 100

]
