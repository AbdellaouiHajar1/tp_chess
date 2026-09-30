Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testPawnCanCaptureDiagonally [
	"Bug actuel : le pion ne peut pas capturer en diagonale"
	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	whitePawn := MyPawn white.
	blackPawn := MyPawn black.
	board at: 'e4' put: whitePawn.
	board at: 'd5' put: blackPawn.
	self assert: (whitePawn legalTargetSquares includes: (board at: 'd5')).
]

{ #category : 'tests' }
MyPawnTest >> testPawnCanMoveTwoSquaresFromStart [
	"Bug actuel : le pion ne peut pas avancer de 2 cases"
	| board pawn |
	board := MyChessBoard empty.
	pawn := MyPawn white.
	board at: 'e2' put: pawn.
	self assert: (pawn legalTargetSquares includes: (board at: 'e4')).
]

{ #category : 'tests' }
MyPawnTest >> testPawnShouldNotCaptureForward [
	| board whitePawn blackPawn |
	
	board := MyChessBoard empty.
	whitePawn := MyPawn white.
	blackPawn := MyPawn black.

	board at: 'e4' put: whitePawn.
	board at: 'e5' put: blackPawn.
	
	
	self deny: (whitePawn legalTargetSquares includes: (board at: 'e5')).
]
