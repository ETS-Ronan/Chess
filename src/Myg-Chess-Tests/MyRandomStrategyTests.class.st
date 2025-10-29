Class {
	#name : 'MyRandomStrategyTests',
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
MyRandomStrategyTests >> setUp [
	super setUp.
	board := MyChessBoard empty.
	player := MyPlayer new.
	player color: Color white.
	player game: board.
	strategy := MyRandomStrategy new.
	strategy player: player.
]

{ #category : 'tests' }
MyRandomStrategyTests >> testChooseMoveReturnsValidMove [
	"Tester que la stratégie aléatoire renvoie un coup valide lorsque des pièces peuvent jouer"
	| move |
	board at: 'e2' put: MyPawn white.
	board at: 'd2' put: MyPawn white.
	board at: 'e1' put: MyKing white.
	
	move := strategy chooseMove.
	
	self assert: move notNil.
	self assert: move size equals: 2.
	self assert: move first isPiece.
	self assert: (move second isKindOf: MyChessSquare).
]

{ #category : 'tests' }
MyRandomStrategyTests >> testChooseMoveWithKingInCheck [
	"Tester que la stratégie aléatoire donne la priorité au roi lorsqu’il est en échec"
	| move |
	"Créer une position où le roi blanc est en échec"
	board at: 'e1' put: MyKing white.
	board at: 'e8' put: MyRook black.
	board at: 'd2' put: MyPawn white.
	
	move := strategy chooseMove.
	
	"Le coup devrait concerner le roi puisqu’il est en échec"
	self assert: move notNil.
	self assert: move first isKing.
]

{ #category : 'tests' }
MyRandomStrategyTests >> testChooseMoveWithNoMovesReturnsNil [
	"Tester que la stratégie aléatoire renvoie nil lorsqu’aucun coup n’est possible"
	| move |
	"Créer un plateau contenant uniquement un roi blanc entouré de pièces noires"
	board at: 'e4' put: MyKing white.
	board at: 'e5' put: MyRook black.
	board at: 'e3' put: MyRook black.
	board at: 'd4' put: MyRook black.
	board at: 'f4' put: MyRook black.
	board at: 'd5' put: MyRook black.
	board at: 'f5' put: MyRook black.
	board at: 'd3' put: MyRook black.
	board at: 'f3' put: MyRook black.
	
	move := strategy chooseMove.
	
	self assert: move isNil.
]
