Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> blackCaptureSquares [
	| squares |
	squares := OrderedCollection new.
	{ square downLeft . square downRight } do: [ :s |
		(s notNil and: [ s hasPiece and: [ s contents color ~= color ] ])
			ifTrue: [ squares add: s ] ].
	^ squares
]

{ #category : 'as yet unclassified' }
MyPawn >> blackForwardSquares [
	| squares oneStep twoSteps |
	squares := OrderedCollection new.
	oneStep := square down.
	(oneStep notNil and: [ oneStep hasPiece not ]) ifTrue: [
		squares add: oneStep.
		square file = $7 ifTrue: [
			twoSteps := oneStep down.
			(twoSteps notNil and: [ twoSteps hasPiece not ])
				ifTrue: [ squares add: twoSteps ] ] ].
	^ squares
]

{ #category : 'as yet unclassified' }
MyPawn >> captureSquares [
	^ self isWhite
		ifTrue: [ self whiteCaptureSquares ]
		ifFalse: [ self blackCaptureSquares ]
]

{ #category : 'as yet unclassified' }
MyPawn >> forwardSquares [
	^ self isWhite
		ifTrue: [ self whiteForwardSquares ]
		ifFalse: [ self blackForwardSquares ]
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [
	| moves |
	moves := OrderedCollection new.
	moves addAll: self forwardSquares.
	moves addAll: self captureSquares.
	^ moves
]

{ #category : 'as yet unclassified' }
MyPawn >> whiteCaptureSquares [
	| squares |
	squares := OrderedCollection new.
	{ square upLeft . square upRight } do: [ :s |
		(s notNil and: [ s hasPiece and: [ s contents color ~= color ] ])
			ifTrue: [ squares add: s ] ].
	^ squares
]

{ #category : 'as yet unclassified' }
MyPawn >> whiteForwardSquares [
	| squares oneStep twoSteps |
	squares := OrderedCollection new.
	oneStep := square up.
	(oneStep notNil and: [ oneStep hasPiece not ]) ifTrue: [
		squares add: oneStep.
		square file = $2 ifTrue: [
			twoSteps := oneStep up.
			(twoSteps notNil and: [ twoSteps hasPiece not ])
				ifTrue: [ squares add: twoSteps ] ] ].
	^ squares
]
