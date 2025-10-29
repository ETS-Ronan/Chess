Class {
	#name : 'MyWorstMoveStrategy',
	#superclass : 'MyPlayerStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyWorstMoveStrategy >> chooseMove [
    | movesWithScore bestWorstMove|
    movesWithScore := OrderedCollection new.
    player pieces do: [:piece |
        piece legalTargetSquares do: [:sq |
            | score |
            "Si la cible contient une pièce ennemie, score = +value (gain), sinon 0"
            (sq contents notNil and: [ sq contents color ~= piece color ])
                ifTrue: [ score := sq contents value ]
                ifFalse: [ score := 0 ].

            movesWithScore add: (score -> { piece. sq }) ] ].

    movesWithScore isEmpty ifTrue: [ ^ nil ].

    "On choisit le plus petit score (le “pire” gain)"
    bestWorstMove := (movesWithScore sorted: [:a :b | a key < b key]) first value.

    ^ bestWorstMove

]
