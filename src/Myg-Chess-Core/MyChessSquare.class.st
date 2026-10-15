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

{ #category : 'as yet unclassified' }
MyChessSquare class >> pieceLetters [

	| table |
	table := Dictionary new.
	table at: (Array with: MyKing with: true) put: 'K'.
	table at: (Array with: MyKing with: false) put: 'L'.
	table at: (Array with: MyQueen with: true) put: 'Q'.
	table at: (Array with: MyQueen with: false) put: 'W'.
	table at: (Array with: MyRook with: true) put: 'R'.
	table at: (Array with: MyRook with: false) put: 'T'.
	table at: (Array with: MyBishop with: true) put: 'B'.
	table at: (Array with: MyBishop with: false) put: 'V'.
	table at: (Array with: MyKnight with: true) put: 'N'.
	table at: (Array with: MyKnight with: false) put: 'M'.
	table at: (Array with: MyPawn with: true) put: 'P'.
	table at: (Array with: MyPawn with: false) put: 'O'.
	^ table
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

	^ board at: column , file ifAbsent: [ MyOffBoardSquare new ]
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

	contents := aPiece.
	piece text: ((contents renderPieceOn: self) asRopedText
			 fontSize: 48;
			 foreground: self foreground;
			 fontName: MyOpenChessDownloadedFont new familyName)
]

{ #category : 'api - configuration' }
MyChessSquare >> down [

	^ self + (0 @ -1)
]

{ #category : 'as yet unclassified' }
MyChessSquare >> downLeft [
	^ self down left 

]

{ #category : 'as yet unclassified' }
MyChessSquare >> downRight [
	^ self down right 
]

{ #category : 'asd' }
MyChessSquare >> emptyContents [

	self contents: MyNullPiece new
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

{ #category : 'testing' }
MyChessSquare >> hasPiece [

	^ contents hasPiece
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

{ #category : 'testing' }
MyChessSquare >> isOnBoard [

	^ true
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

{ #category : 'printing' }
MyChessSquare >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : 'rendering' }
MyChessSquare >> renderPiece: aPiece [

	| letter |
	letter := aPiece isWhite
		          ifTrue: [ aPiece whiteId ]
		          ifFalse: [ aPiece blackId ].
	^ color isBlack
		  ifTrue: [ letter asLowercase ]
		  ifFalse: [ letter asUppercase ]
]

{ #category : 'rendering' }
MyChessSquare >> renderPieceOn: aSquare [

	^ aSquare color isBlack
		  ifFalse: [ 'z' ]
		  ifTrue: [ 'x' ]
]

{ #category : 'rendering' }
MyChessSquare >> renderPieceViaTable: aPiece [

	| letter |
	letter := self class pieceLetters
		           at: (Array with: aPiece class with: aPiece isWhite).
	^ color isBlack
		  ifTrue: [ letter asLowercase ]
		  ifFalse: [ letter asUppercase ]
]

{ #category : 'accessing' }
MyChessSquare >> right [
	
	^ self + (1@0)
]

{ #category : 'initialization' }
MyChessSquare >> select [
	
	self border: Color green
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

{ #category : 'as yet unclassified' }
MyChessSquare >> upLeft [
	^ self up left

]

{ #category : 'as yet unclassified' }
MyChessSquare >> upRight [
	^ self up right 


]
