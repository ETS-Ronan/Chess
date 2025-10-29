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
	board at: 'e4' put: MyKing white.
	board at: 'e5' put: MyRook black.
	board at: 'e3' put: MyRook black.
	board at: 'd4' put: MyRook black.
	board at: 'f4' put: MyRook black.
	
	player game: board.
	
	move := strategy chooseMove.
	
	self assert: move isNil.
]
