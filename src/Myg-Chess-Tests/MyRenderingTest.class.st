Class {
	#name : 'MyRenderingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyRenderingTest >> testBishopRendering [

	self assert: (MyChessSquare white renderPiece: MyBishop white) equals: 'B'.
	self assert: (MyChessSquare black renderPiece: MyBishop white) equals: 'b'.
	self assert: (MyChessSquare white renderPiece: MyBishop black) equals: 'V'.
	self assert: (MyChessSquare black renderPiece: MyBishop black) equals: 'v'
]

{ #category : 'tests' }
MyRenderingTest >> testKingRendering [

	self assert: (MyChessSquare white renderPiece: MyKing white) equals: 'K'.
	self assert: (MyChessSquare black renderPiece: MyKing white) equals: 'k'.
	self assert: (MyChessSquare white renderPiece: MyKing black) equals: 'L'.
	self assert: (MyChessSquare black renderPiece: MyKing black) equals: 'l'
]

{ #category : 'tests' }
MyRenderingTest >> testKnightRendering [

	self assert: (MyChessSquare white renderPiece: MyKnight white) equals: 'N'.
	self assert: (MyChessSquare black renderPiece: MyKnight white) equals: 'n'.
	self assert: (MyChessSquare white renderPiece: MyKnight black) equals: 'M'.
	self assert: (MyChessSquare black renderPiece: MyKnight black) equals: 'm'
]

{ #category : 'tests' }
MyRenderingTest >> testNewRenderingMatchesOld [

	self assert: (MyChessSquare white renderPiece: MyKnight white) equals: 'N'.
	self assert: (MyChessSquare black renderPiece: MyKnight white) equals: 'n'.
	self assert: (MyChessSquare white renderPiece: MyKnight black) equals: 'M'.
	self assert: (MyChessSquare black renderPiece: MyKnight black) equals: 'm'.
	self assert: (MyChessSquare white renderPiece: MyKing white) equals: 'K'.
	self assert: (MyChessSquare black renderPiece: MyKing black) equals: 'l'
]

{ #category : 'tests' }
MyRenderingTest >> testPawnRendering [

	self assert: (MyChessSquare white renderPiece: MyPawn white) equals: 'P'.
	self assert: (MyChessSquare black renderPiece: MyPawn white) equals: 'p'.
	self assert: (MyChessSquare white renderPiece: MyPawn black) equals: 'O'.
	self assert: (MyChessSquare black renderPiece: MyPawn black) equals: 'o'
]

{ #category : 'tests' }
MyRenderingTest >> testQueenRendering [

	self assert: (MyChessSquare white renderPiece: MyQueen white) equals: 'Q'.
	self assert: (MyChessSquare black renderPiece: MyQueen white) equals: 'q'.
	self assert: (MyChessSquare white renderPiece: MyQueen black) equals: 'W'.
	self assert: (MyChessSquare black renderPiece: MyQueen black) equals: 'w'
]

{ #category : 'tests' }
MyRenderingTest >> testRookRendering [

	self assert: (MyChessSquare white renderPiece: MyRook white) equals: 'R'.
	self assert: (MyChessSquare black renderPiece: MyRook white) equals: 'r'.
	self assert: (MyChessSquare white renderPiece: MyRook black) equals: 'T'.
	self assert: (MyChessSquare black renderPiece: MyRook black) equals: 't'
]

{ #category : 'tests' }
MyRenderingTest >> testTableDispatchMatchesOld [

	self assert: (MyChessSquare white renderPieceViaTable: MyKnight white) equals: 'N'.
	self assert: (MyChessSquare black renderPieceViaTable: MyKnight white) equals: 'n'.
	self assert: (MyChessSquare white renderPieceViaTable: MyKnight black) equals: 'M'.
	self assert: (MyChessSquare black renderPieceViaTable: MyKnight black) equals: 'm'.
	self assert: (MyChessSquare white renderPieceViaTable: MyKing white) equals: 'K'.
	self assert: (MyChessSquare black renderPieceViaTable: MyKing black) equals: 'l'
]
