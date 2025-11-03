Class {
	#name : 'MyPieceValueTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'accessing' }
MyPieceValueTest >> testAllPieceValues [
	self assert: MyPawn new value equals: 1.
	self assert: MyKnight new value equals: 3.
	self assert: MyBishop new value equals: 3.
	self assert: MyRook new value equals: 5.
	self assert: MyQueen new value equals: 9.
	self assert: MyKing new value equals: 100.

]
