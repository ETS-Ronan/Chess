Class {
	#name : 'MyCaptureStrategy',
	#superclass : 'MyPlayerStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyCaptureStrategy >> chooseMove [
    | captureMoves normalMoves |
    captureMoves := OrderedCollection new.
    normalMoves := OrderedCollection new.
    
    player pieces do: [ :piece |
        piece legalTargetSquares do: [ :sq |
            sq hasPiece
                ifTrue: [
                    (sq contents color ~= piece color)
                        ifTrue: [ captureMoves add: { piece. sq } ] ]
                ifFalse: [ normalMoves add: { piece. sq } ] ] ].

    "Si des captures sont possibles, en choisir une au hasard"
    (captureMoves isEmpty not)
        ifTrue: [ ^ captureMoves atRandom ].

    "Sinon, jouer un coup normal aléatoire"
    normalMoves isEmpty
        ifTrue: [ ^ nil ]  "aucun coup possible"
        ifFalse: [ ^ normalMoves atRandom ].

]
