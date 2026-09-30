Class {
	#name : 'MyPlayerTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'as yet unclassified' }
MyPlayerTest >> boardFromFEN: aString [

	^ MyChessBoard fromFENBoard: (MyFENParser parse: aString) board
]

{ #category : 'tests' }
MyPlayerTest >> testPlayMovesAPiece [

	| game piecesBefore piecesAfter |
	game := MyChessGame freshGame.
	piecesBefore := (game pieces select: #notNil) size.

	game play.

	piecesAfter := (game pieces select: #notNil) size.
	self assert: piecesAfter equals: piecesBefore
]
