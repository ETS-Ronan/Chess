Class {
	#name : 'MyBishopTestDouble',
	#superclass : 'MyBishop',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'rendering' }
MyBishopTestDouble >> downLeftDiagonalLegal: aBoolean [  ^ #(dl)



]

{ #category : 'rendering' }
MyBishopTestDouble >> downRightDiagonalLegal: aBoolean [ ^ #(dr)



]

{ #category : 'rendering' }
MyBishopTestDouble >> upLeftDiagonalLegal: aBoolean [  
  ^ #(ul)

]

{ #category : 'rendering' }
MyBishopTestDouble >> upRightDiagonalLegal: aBoolean [  
 ^ #(ur)

]
