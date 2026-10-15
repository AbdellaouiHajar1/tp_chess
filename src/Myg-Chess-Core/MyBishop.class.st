Class {
	#name : 'MyBishop',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyBishop >> blackId [
	^ 'V'
]

{ #category : 'accessing' }
MyBishop >> id [
	
	^ 'B'
]

{ #category : 'rendering' }
MyBishop >> targetSquaresLegal: aBoolean [

	^ (self upRightDiagonalLegal: aBoolean)
	  , (self upLeftDiagonalLegal: aBoolean)
	  , (self downRightDiagonalLegal: aBoolean)
	  , (self downLeftDiagonalLegal: aBoolean)
]

{ #category : 'as yet unclassified' }
MyBishop >> whiteId [
	^ 'B'
]
