Class {
	#name : 'MyPiece',
	#superclass : 'Object',
	#instVars : [
		'color',
		'square'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPiece class >> black [

	^ self new
		  color: Color black;
		  yourself
]

{ #category : 'constants' }
MyPiece class >> white [

	^ self new
		  color: Color white;
		  yourself
]

{ #category : 'as yet unclassified' }
MyPiece >> attackingSquares [

	^ self targetSquaresLegal: true
]

{ #category : 'path commands' }
MyPiece >> board [

	^ square board
]

{ #category : 'rendering' }
MyPiece >> collectSquares: aBlock [

	^ self collectSquares: aBlock legal: false
]

{ #category : 'rendering' }
MyPiece >> collectSquares: aBlock legal: shouldBeLegal [

	^ self collectSquares: aBlock while: [ :aSquare |
		  aSquare isOnBoard and: [ shouldBeLegal ==> aSquare hasPiece not ] ]
]

{ #category : 'rendering' }
MyPiece >> collectSquares: collectBlock while: untilBlock [

	| targets next |
	targets := OrderedCollection new.

	"Collect up right"
	next := square.
	[ untilBlock value: (next := collectBlock value: next) ]
		whileTrue: [ targets add: next ].

	"If we can it the next piece, then add it too"
	(next isOnBoard and: [ next contents color ~= color ]) ifTrue: [ targets add: next ].

	^ targets
]

{ #category : 'accessing' }
MyPiece >> color [

	^ color
]

{ #category : 'accessing' }
MyPiece >> color: aColor [

	color := aColor
]

{ #category : 'as yet unclassified' }
MyPiece >> doesNotLeaveKingInCheckWhenMovedTo: aSquare [
	| originalSquare originalContents king isInCheckAfterMove |
	originalSquare := square.
	originalContents := aSquare contents.

	[ "Simule le coup"
	  square emptyContents.
	  aSquare contents: self.
	  square := aSquare.

	  "Mon roi est-il en échec après ce coup ?"
	  king := self ownKing.
	  isInCheckAfterMove := king
		  ifNil: [ false ]
		  ifNotNil: [ king isInCheck ] ]
		ensure: [ "Annule le coup"
			aSquare contents: originalContents.
			originalSquare contents: self.
			square := originalSquare ].

	^ isInCheckAfterMove not
]

{ #category : 'rendering' }
MyPiece >> downFile [

	^ self downFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> downFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare down ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> downLeftDiagonal [

	^ self downLeftDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> downLeftDiagonalLegal: aBoolean [

	^ self
		  collectSquares: [ :aSquare | aSquare down ifNotNil: #left ]
		  legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> downRightDiagonal [

	^ self downRightDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> downRightDiagonalLegal: aBoolean [

	^ self
		  collectSquares: [ :aSquare | aSquare down ifNotNil: #right ]
		  legal: aBoolean
]

{ #category : 'testing' }
MyPiece >> hasPiece [

	^ true
]

{ #category : 'accessing' }
MyPiece >> id [

	^ 'Q'
]

{ #category : 'testing' }
MyPiece >> isKing [
	
	^ false
]

{ #category : 'testing' }
MyPiece >> isPiece [
	
	^ true
]

{ #category : 'testing' }
MyPiece >> isWhite [
	
	^ color isBlack not
]

{ #category : 'rendering' }
MyPiece >> leftFile [

	^ self leftFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> leftFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare left ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> legalTargetSquares [

	^ (self targetSquaresLegal: true) select: [ :aSquare |
		  self doesNotLeaveKingInCheckWhenMovedTo: aSquare ]
]

{ #category : 'path commands' }
MyPiece >> moveTo: aSquare [

	(self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

	square emptyContents.
	square := aSquare.
	aSquare contents: self
]

{ #category : 'as yet unclassified' }
MyPiece >> ownKing [
	"Le roi de ma couleur, ou nil s'il n'y en a pas sur le plateau"

	^ self board pieces
		detect: [ :p | p notNil and: [ p isKing and: [ p color = color ] ] ]
		ifNone: [ nil ]
]

{ #category : 'rendering' }
MyPiece >> rightFile [

	^ self rightFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> rightFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare right ] legal: aBoolean
]

{ #category : 'accessing' }
MyPiece >> square [
	^ square
]

{ #category : 'accessing' }
MyPiece >> square: aMyChessSquare [ 
	
	square := aMyChessSquare
]

{ #category : 'rendering' }
MyPiece >> targetSquares [

	^ self targetSquaresLegal: false
]

{ #category : 'rendering' }
MyPiece >> targetSquaresLegal: aBoolean [

	^self subclassResponsibility select: [ :aSquare |
		  self doesNotLeaveKingInCheckWhenMovedTo: aSquare ]
]

{ #category : 'rendering' }
MyPiece >> upFile [

	^ self upFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> upFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare up ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> upLeftDiagonal [

	^ self upLeftDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> upLeftDiagonalLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare up ifNotNil: #left ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> upRightDiagonal [

	^ self upRightDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> upRightDiagonalLegal: aBoolean [

	^ self
		  collectSquares: [ :aSquare | aSquare up ifNotNil: #right ]
		  legal: aBoolean
]
