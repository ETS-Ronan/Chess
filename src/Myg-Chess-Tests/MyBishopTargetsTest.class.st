Class {
	#name : 'MyBishopTargetsTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyBishopTargetsTest >> testTargetSquaresLegalConcatenatesFourDiagonalsInOrder [
	| res |
	res := MyBishopTestDouble new targetSquaresLegal: true.
	self assert: res asArray equals: #(ur ul dr dl).

]
