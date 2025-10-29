Class {
	#name : 'MyRandomStrategy',
	#superclass : 'MyPlayerStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyRandomStrategy >> chooseMove [
    | pieces |
    pieces := player king isInCheck
                  ifTrue: [ OrderedCollection with: player king ]
                  ifFalse: [ player pieces copy asOrderedCollection ].

    [ pieces notEmpty ] whileTrue: [ 
        | piece legalMoves |
        piece := pieces atRandom.
        pieces remove: piece.
        legalMoves := piece legalTargetSquares.
        legalMoves ifNotEmpty: [
            ^ { piece. legalMoves atRandom } ] ].

    ^ nil
]
