Class {
	#name : 'MyAlphaMoveStrategyTests',
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
MyAlphaMoveStrategyTests >> setUp [
	super setUp.
	board := MyChessBoard empty.
	player := MyPlayer new white.
	strategy := MyAlphaMoveStrategy new.
	strategy player: player.
]

{ #category : 'tests' }
MyAlphaMoveStrategyTests >> testChoosesAlphabeticallyFirstMove [
	"Tester que la stratégie alphabétique choisit le premier coup dans l’ordre alphabétique"
	| move |
	board at: 'e2' put: MyPawn white.
	board at: 'd2' put: MyPawn white.
	
	player game: board.
	
	move := strategy chooseMove.
	
	self assert: move notNil.
	self assert: move first square name equals: 'd2'.
	
]

{ #category : 'tests' }
MyAlphaMoveStrategyTests >> testReturnsNilWhenNoMoves [
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
