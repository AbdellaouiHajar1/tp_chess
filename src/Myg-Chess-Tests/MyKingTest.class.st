Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testCannotMovePieceIfKingRemainsInCheck [
	| board whiteKing whitePawn blackRook |
	
	board := MyChessBoard empty.
	
	"Roi blanc en e1"
	whiteKing := MyKing white.
	board at: 'e1' put: whiteKing.
	
	"Pion blanc en d2"
	whitePawn := MyPawn white.
	board at: 'd2' put: whitePawn.
	
	"Tour noire en e8 qui met le roi en échec"
	blackRook := MyRook black.
	board at: 'e8' put: blackRook.
	
	"Le pion ne doit PAS pouvoir avancer"
	self deny: (whitePawn legalTargetSquares includes: (board at: 'd3')).
	
	"Le roi doit pouvoir bouger pour sortir de l'échec"
	self assert: (whiteKing legalTargetSquares includes: (board at: 'd1')).
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]
