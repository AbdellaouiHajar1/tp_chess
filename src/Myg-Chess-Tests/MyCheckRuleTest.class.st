Class {
	#name : 'MyCheckRuleTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'as yet unclassified' }
MyCheckRuleTest >> boardFromFEN: aString [

	^ MyChessBoard fromFENBoard: (MyFENParser parse: aString) board
]

{ #category : 'as yet unclassified' }
MyCheckRuleTest >> checkRandomIllegalMoveOn: fen [

	| board piece legal illegal before |
	board := self boardFromFEN: fen.
	piece := (board pieces select: #notNil) atRandom.
	legal := piece legalTargetSquares.
	
	"cooriger prb lente requete :illegal := (board children reject: [ :s | legal includes: s ]) atRandom."
	illegal := (board children reject: [ :s |
	            piece legalTargetSquares includes: s ]) atRandom.
	before := piece square.

	piece moveTo: illegal.

	self
		assert: piece square = before
		description: 'Un coup illégal a été accepté. FEN : ' , fen
]

{ #category : 'as yet unclassified' }
MyCheckRuleTest >> checkRandomLegalMoveOn: fen [

	| board piece target king |
	board := self boardFromFEN: fen.
	piece := (board pieces select: #notNil)
		         detect: [ :p | p legalTargetSquares notEmpty ]
		         ifNone: [ ^ self ].
	target := piece legalTargetSquares atRandom.

	piece moveTo: target.

	self
		assert: piece square = target
		description: 'La pièce n''est pas arrivée. FEN : ' , fen.
	king := board pieces
		        detect: [ :p |
			        p notNil and: [ p isKing and: [ p color = piece color ] ] ]
		        ifNone: [ nil ].
	king ifNotNil: [
		self
			deny: king isInCheck
			description: 'Le roi est en échec après un coup légal. FEN : ' , fen ]
]

{ #category : 'as yet unclassified' }
MyCheckRuleTest >> randomFEN [
	"Deux rois + 0 à 14 autres pièces, sans pion sur la 1re ou la 8e rangée"

	| cells indices |
	cells := Array new: 64 withAll: nil.
	indices := (1 to: 64) asArray shuffled.
	cells at: indices first put: $K.
	cells at: (indices at: 2) put: $k.
	3 to: 3 + (0 to: 14) atRandom do: [ :i |
		| letter index |
		letter := 'PNBRQpnbrq' atRandom.
		index := indices at: i.
		((letter = $P or: [ letter = $p ]) and: [ index <= 8 or: [ index > 56 ] ])
			ifTrue: [ letter := $Q ].
		cells at: index put: letter ].
	^ String streamContents: [ :s |
		0 to: 7 do: [ :row |
			| empty |
			empty := 0.
			1 to: 8 do: [ :col |
				| cell |
				cell := cells at: row * 8 + col.
				cell
					ifNil: [ empty := empty + 1 ]
					ifNotNil: [
						empty > 0 ifTrue: [
							s print: empty.
							empty := 0 ].
						s nextPut: cell ] ].
			empty > 0 ifTrue: [ s print: empty ].
			row < 7 ifTrue: [ s nextPut: $/ ] ].
		s nextPutAll: ' w - - 0 1' ]
]

{ #category : 'tests' }
MyCheckRuleTest >> testBishopMustSaveKing [
	"Le roi est en échec : le fou ne peut que bloquer en e2 ou capturer la tour en e8"

	| board bishop |
	board := self boardFromFEN: '4r3/8/8/1B6/8/8/8/4K3 w - - 0 1'.
	bishop := (board at: 'b5') contents.
	self
		assert: bishop legalTargetSquares asSet
		equals: { (board at: 'e2'). (board at: 'e8') } asSet
]

{ #category : 'tests' }
MyCheckRuleTest >> testBoardWithTwoWhiteKingsDoesNotHang [

	| board |
	board := self boardFromFEN: '4K3/8/8/8/8/8/8/4K3 w - - 0 1'.
	self assert: (board pieces select: #notNil) size equals: 2
]

{ #category : 'tests' }
MyCheckRuleTest >> testBoardWithoutKingDoesNotHang [

	| board |
	board := self boardFromFEN: '8/8/8/8/8/8/8/8 w - - 0 1'.
	self assert: (board pieces select: #notNil) isEmpty
]

{ #category : 'tests' }
MyCheckRuleTest >> testEmptySquareHasNoPiece [

	| board |
	board := self boardFromFEN: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.
	self deny: (board at: 'e4') hasPiece
]

{ #category : 'tests' }
MyCheckRuleTest >> testFreeBishopHasAllItsMoves [


	| board bishop |
	board := self boardFromFEN: '8/8/8/8/8/8/4B3/4K3 w - - 0 1'.
	bishop := (board at: 'e2') contents.
	self assert: bishop legalTargetSquares size equals: 9
]

{ #category : 'tests' }
MyCheckRuleTest >> testIllegalMoveIsRefused [

	200 timesRepeat: [
		| fen |
		fen := self randomFEN.
		[ self checkRandomIllegalMoveOn: fen ]
			on: Error
			do: [ :e |
				self fail: 'Erreur "' , e messageText printString , '" sur : ' , fen ] ]
]

{ #category : 'tests' }
MyCheckRuleTest >> testPawnOnLastRankDoesNotHang [

	| board |
	board := self boardFromFEN: '4P3/8/8/8/8/8/8/4K3 w - - 0 1'.
	self assert: ((board at: 'e8') contents) notNil
]

{ #category : 'tests' }
MyCheckRuleTest >> testPinnedBishopCannotMove [
	

	| board bishop |
	board := self boardFromFEN: '4r3/8/8/8/8/8/4B3/4K3 w - - 0 1'.
	bishop := (board at: 'e2') contents.
	self assert: bishop legalTargetSquares isEmpty
]

{ #category : 'tests' }
MyCheckRuleTest >> testRandomLegalMovesKeepInvariants [

	200 timesRepeat: [
		| fen |
		fen := self randomFEN.
		[ self checkRandomLegalMoveOn: fen ]
			on: Error
			do: [ :e |
				self fail: 'Erreur "' , e messageText printString , '" sur : ' , fen ] ]
]

{ #category : 'tests' }
MyCheckRuleTest >> testRookInCornerCannotGoFurtherLeft [

	| board |
	board := self boardFromFEN: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.
	self deny: (board at: 'a1') left hasPiece
]
