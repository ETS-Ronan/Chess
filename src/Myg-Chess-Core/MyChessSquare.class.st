Class {
	#name : 'MyChessSquare',
	#superclass : 'BlElement',
	#instVars : [
		'color',
		'name',
		'label',
		'piece',
		'contents',
		'board',
		'target'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'api - text weight' }
MyChessSquare class >> black [

	^ self color: Color black
]

{ #category : 'api - text weight' }
MyChessSquare class >> color: aColor [

	^ self basicNew
		  color: aColor;
		  initialize;
		  yourself
]

{ #category : 'api - text weight' }
MyChessSquare class >> white [

	^ self color: Color white
]

{ #category : 'arithmetic' }
MyChessSquare >> + aPoint [

	| column file |
	column := (self column asciiValue + aPoint x) asCharacter asString.
	file := (self file asciiValue + aPoint y) asCharacter asString.

	^ board at: column , file ifAbsent: [ ^ nil ]
]

{ #category : 'instance creation' }
MyChessSquare >> applyCaseForSquareTo: aGlyph [
	"Light square keeps case; dark square uses lowercase."
	| transform |
	transform := Dictionary newFrom: {
		#light -> [ :c | c ].
		#dark  -> [ :c | c asLowercase ]
	}.
	^ (transform at: self squareColorKey) value: aGlyph

]

{ #category : 'accessing' }
MyChessSquare >> board [
	^ board
]

{ #category : 'accessing' }
MyChessSquare >> board: aMyChessBoard [ 
	
	board := aMyChessBoard
]

{ #category : 'initialization' }
MyChessSquare >> click [

	board click: self
]

{ #category : 'accessing' }
MyChessSquare >> color [

	^ color
]

{ #category : 'accessing' }
MyChessSquare >> color: anObject [

	color := anObject
]

{ #category : 'accessing' }
MyChessSquare >> column [
	
	^ name first
]

{ #category : 'accessing' }
MyChessSquare >> contents [
	^ contents
]

{ #category : 'accessing' }
MyChessSquare >> contents: aPiece [
	| text chooser |
	contents := aPiece.

	chooser := Dictionary newFrom: {
		true  -> [ self emptyGlyph ].
		false -> [ contents renderPieceOn: self ]
	}.

	text := (chooser at: contents isNil) value.

	piece text: (text asRopedText
		fontSize: 48;
		foreground: self foreground;
		fontName: MyOpenChessDownloadedFont new familyName)

]

{ #category : 'api - configuration' }
MyChessSquare >> down [

	^ self + (0 @ -1)
]

{ #category : 'asd' }
MyChessSquare >> emptyContents [
	
	self contents: nil
]

{ #category : 'instance creation' }
MyChessSquare >> emptyGlyph [
	"Empty-square glyph by square color, no if."
	^ (Dictionary newFrom: {
		#light -> 'z'.
		#dark  -> 'x'
	}) at: self squareColorKey

]

{ #category : 'accessing' }
MyChessSquare >> file [
	
	^ name second
]

{ #category : 'accessing' }
MyChessSquare >> foreground [
			
	^ color isBlack
		ifTrue: [ board blackColor ]
		ifFalse: [ board whiteColor ]
]

{ #category : 'instance creation' }
MyChessSquare >> glyphTable [
	"Base glyph per piece type and piece color (no ifs)."
	^ Dictionary newFrom: {
		#MyKing   -> (Dictionary newFrom: { #white -> 'K'. #black -> 'L' }).
		#MyQueen  -> (Dictionary newFrom: { #white -> 'Q'. #black -> 'W' }).
		#MyBishop -> (Dictionary newFrom: { #white -> 'B'. #black -> 'V' }).
		#MyKnight -> (Dictionary newFrom: { #white -> 'N'. #black -> 'M' }).
		#MyRook   -> (Dictionary newFrom: { #white -> 'R'. #black -> 'T' }).
		#MyPawn   -> (Dictionary newFrom: { #white -> 'P'. #black -> 'O' })
	}

]

{ #category : 'testing' }
MyChessSquare >> hasPiece [
	
	^ contents isNil not
]

{ #category : 'highlighting' }
MyChessSquare >> highlightTarget [

	self addChild: target
]

{ #category : 'initialization' }
MyChessSquare >> initialize [

	super initialize.
	target := BlElement new
		  geometry: BlCircleGeometry new;
		  background: (Color gray alpha: 0.3).

	self layout: BlFrameLayout new.

	label := BlTextElement new.
	label constraintsDo: [ :c | c padding: (BlInsets all: 3) ].

	piece := BlTextElement new.
	piece text: '' asRopedText.
	piece constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	self
		addChild: label;
		addChild: piece.
	self
		background: Color white;
		geometry: BlSquareGeometry new.

	self addEventHandlerOn: BlClickEvent do: [ :e | self click ]
]

{ #category : 'accessing' }
MyChessSquare >> left [

	^ self + (-1 @ 0)
]

{ #category : 'accessing' }
MyChessSquare >> name [
	^ name
]

{ #category : 'accessing' }
MyChessSquare >> name: aString [

	name := aString.
	label text: (name asRopedText foreground: color negated)
]

{ #category : 'instance creation' }
MyChessSquare >> pieceColorKeyFor: aPiece [
	"true/false -> #white/#black via table dispatch."
	^ (Dictionary newFrom: {
		true  -> #white.
		false -> #black
	}) at: aPiece isWhite

]

{ #category : 'printing' }
MyChessSquare >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : 'rendering' }
MyChessSquare >> renderBishop: aPiece [  ^ self renderFromTable: aPiece
]

{ #category : 'instance creation' }
MyChessSquare >> renderFromTable: aPiece [
	"Generic renderer using tables only."
	| typeKey baseGlyph |
	aPiece ifNil: [ ^ self emptyGlyph ].

	typeKey := aPiece class name asSymbol.
	baseGlyph :=
		((self glyphTable at: typeKey ifAbsent: [ Dictionary new ])
			at: (self pieceColorKeyFor: aPiece)
			ifAbsent: [ '?' ]).

	^ self applyCaseForSquareTo: baseGlyph

]

{ #category : 'rendering' }
MyChessSquare >> renderKing:   aPiece [  ^ self renderFromTable: aPiece
]

{ #category : 'rendering' }
MyChessSquare >> renderKnight: aPiece [  ^ self renderFromTable: aPiece
]

{ #category : 'rendering' }
MyChessSquare >> renderPawn:   aPiece [  ^ self renderFromTable: aPiece
]

{ #category : 'rendering' }
MyChessSquare >> renderQueen:  aPiece [  ^ self renderFromTable: aPiece
]

{ #category : 'rendering' }
MyChessSquare >> renderRook:   aPiece [  ^ self renderFromTable: aPiece

]

{ #category : 'accessing' }
MyChessSquare >> right [
	
	^ self + (1@0)
]

{ #category : 'initialization' }
MyChessSquare >> select [
	
	self border: Color green
]

{ #category : 'instance creation' }
MyChessSquare >> squareColorKey [
	"Return #light or #dark from square color, no if."
	^ (Dictionary newFrom: {
		true  -> #dark.
		false -> #light
	}) at: color isBlack

]

{ #category : 'highlighting' }
MyChessSquare >> unhighlightTarget [

	self removeChild: target
]

{ #category : 'initialization' }
MyChessSquare >> unselect [

	self border: BlBorder empty
]

{ #category : 'instance creation' }
MyChessSquare >> up [
	
	^ self + (0@1)
]
