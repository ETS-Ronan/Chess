Class {
	#name : 'MyWorstMoveStrategyTests',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'player',
		'strategy'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'running' }
MyWorstMoveStrategyTests >> setUp [
	super setUp.
	board := MyChessBoard empty.
	player := MyPlayer new white.
	strategy := MyWorstMoveStrategy new.
	strategy player: player.
]

{ #category : 'tests' }
MyWorstMoveStrategyTests >> testChoosesNonCapturingMoveOverCapture [
	| move |
	board at: 'e2' put: MyPawn white.
	board at: 'd4' put: MyRook white.
	board at: 'd8' put: MyQueen black.
	
	player game: board.
	
	move := strategy chooseMove.
	
	self assert: move notNil.
	self assert: (move first isKindOf: MyPawn).
]

{ #category : 'tests' }
MyWorstMoveStrategyTests >> testReturnsNilWhenNoMoves [
	| move |
	"Position sans aucun coup blanc légal"
board at: 'e4' put: MyKing white.

board at: 'e5' put: MyKing black.
board at: 'e3' put: MyKing black.
board at: 'd4' put: MyKing black.
board at: 'f4' put: MyKing black.
board at: 'd5' put: MyKing black.
board at: 'f5' put: MyKing black.
board at: 'd3' put: MyKing black.
board at: 'f3' put: MyKing black.

player game: board.
move := strategy chooseMove.
self assert: move isNil.

	
	player game: board.
	
	move := strategy chooseMove.
	
	self assert: (move isNil or: [ move isEmpty ]).
]
