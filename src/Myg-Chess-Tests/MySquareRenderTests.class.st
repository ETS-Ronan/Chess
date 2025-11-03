Class {
	#name : 'MySquareRenderTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MySquareRenderTests >> testBishopWhiteLightVsDark [
	| light dark b |
	light := MyChessSquare white.
	dark  := MyChessSquare black.
	b := MyBishop white.

	self assert: (light renderFromTable: b) equals: 'B'.
	self assert: (dark  renderFromTable: b) equals: 'b'.

]

{ #category : 'tests' }
MySquareRenderTests >> testKingWhiteLightVsDark [
	| light dark k |
	light := MyChessSquare white.
	dark  := MyChessSquare black.
	k := MyKing white.

	self assert: (light renderFromTable: k) equals: 'K'.
	self assert: (dark  renderFromTable: k) equals: 'k'.

]

{ #category : 'tests' }
MySquareRenderTests >> testKnightWhiteLightVsDark [ 
	| light dark n |
	light := MyChessSquare white.
	dark  := MyChessSquare black.
	n := MyKnight white.

	self assert: (light renderFromTable: n) equals: 'N'.
	self assert: (dark  renderFromTable: n) equals: 'n'.

]

{ #category : 'tests' }
MySquareRenderTests >> testPawnBlackLightVsDark [
	| light dark p |
	light := MyChessSquare white.
	dark  := MyChessSquare black.
	p := MyPawn black.

	self assert: (light renderFromTable: p) equals: 'O'.
	self assert: (dark  renderFromTable: p) equals: 'o'.

]

{ #category : 'tests' }
MySquareRenderTests >> testQueenBlackLightVsDark [ 
	| light dark q |
	light := MyChessSquare white.
	dark  := MyChessSquare black.
	q := MyQueen black.

	self assert: (light renderFromTable: q) equals: 'W'.
	self assert: (dark  renderFromTable: q) equals: 'w'.
]

{ #category : 'tests' }
MySquareRenderTests >> testRookBlackLightVsDark [
	| light dark r |
	light := MyChessSquare white.
	dark  := MyChessSquare black.
	r := MyRook black.

	self assert: (light renderFromTable: r) equals: 'T'.
	self assert: (dark  renderFromTable: r) equals: 't'.

]
