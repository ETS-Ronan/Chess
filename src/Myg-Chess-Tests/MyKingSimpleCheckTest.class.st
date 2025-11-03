Class {
	#name : 'MyKingSimpleCheckTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingSimpleCheckTest >> testIsInCheckReturnsFalseWhenNotThreatened [
	| king fakeOpponent |
	
	
	fakeOpponent := Object new.
	fakeOpponent class compile: 'attackingSquares ^ #()'.


	king := MyKing new.
	king color: Color white.
	king square: Object new.

	king class compile: 'opponentPieces ^ { fakeOpponent }'.

	self deny: king isInCheck.

]

{ #category : 'tests' }
MyKingSimpleCheckTest >> testIsInCheckReturnsTrueWhenThreatened [
	| king sq fakeOpponent |
	king := MyKing new.
	king color: Color white.
	sq := Object new.
	king square: sq.

	Smalltalk globals at: #__sq put: sq.
	fakeOpponent := Object new.
	Smalltalk globals at: #__foe put: fakeOpponent.

	"3) l’ennemi attaque EXACTEMENT la même case que le roi"
	fakeOpponent class compile:
		'attackingSquares ^ { Smalltalk globals at: #__sq }'.

	"4) le roi renvoie cet ennemi comme liste d’adversaires (INSTANCE SIDE !)"
	MyKing compile:
		'opponentPieces ^ { Smalltalk globals at: #__foe }'
		classified: 'tests'.

	self assert: king isInCheck.


	Smalltalk globals removeKey: #__sq ifAbsent: [].
	Smalltalk globals removeKey: #__foe ifAbsent: [].

]
