Class {
	#name : 'MyChessBoardTest',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'king',
		'rook',
		'bishop'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'running' }
MyChessBoardTest >> setUp [
	super setUp.
	board := MyChessBoard empty.
   board at: 'e1' put: (king := MyKing white).
   board at: 'e8' put: (rook := MyRook black).
   board at: 'c3' put: (bishop := MyBishop white).
]

{ #category : 'tests' }
MyChessBoardTest >> testSimulateMoveBlocksAttack [
	"Le fou va en e2 et bloque la tour"
	self assert: (board simulateMove: bishop to: (board at: 'e2')).
]

{ #category : 'tests' }
MyChessBoardTest >> testSimulateMoveDoesNotHelp [
	"Le fou va en b2, ça ne bloque pas la tour"
	self deny: (board simulateMove: bishop to: (board at: 'b2')).
]

{ #category : 'tests' }
MyChessBoardTest >> testSimulateMoveKingEscapes [
	"Le roi se déplace en f1 pour sortir de l'échec"
	self assert: (board simulateMove: king to: (board at: 'f1')).
]

{ #category : 'tests' }
MyChessBoardTest >> testSimulateMoveKingIntoDanger [
	"On ajoute une tour noire sur f8, puis on bouge le roi en échec sur f1"
	| rook2 |
	board at: 'f8' put: (rook2 := MyRook black).
	self deny: (board simulateMove: king to: (board at: 'f1')).
]
