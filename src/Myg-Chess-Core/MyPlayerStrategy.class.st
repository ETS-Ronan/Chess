Class {
	#name : 'MyPlayerStrategy',
	#superclass : 'Object',
	#instVars : [
		'player'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPlayerStrategy >> chooseMove [
    self subclassResponsibility.
]

{ #category : 'accessing' }
MyPlayerStrategy >> player: aPlayer [
    player := aPlayer
]
