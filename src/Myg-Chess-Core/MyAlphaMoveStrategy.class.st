Class {
	#name : 'MyAlphaMoveStrategy',
	#superclass : 'MyPlayerStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyAlphaMoveStrategy >> chooseMove [
    | allMoves sortedMoves|
    allMoves := OrderedCollection new.
    
    "Construire toutes les paires {piece . target} avec leur clé alphabétique"
    player pieces do: [ :piece |
        piece legalTargetSquares do: [ :sq |
            | key |
            key := (piece class name asString), '-', (sq name asString).
            allMoves add: (key -> { piece. sq }) ] ].

    sortedMoves := allMoves asSortedCollection: [ :a :b | a key < b key ].

    sortedMoves isEmpty
        ifTrue: [ ^ nil ]
        ifFalse: [ ^ sortedMoves first value ].

]
