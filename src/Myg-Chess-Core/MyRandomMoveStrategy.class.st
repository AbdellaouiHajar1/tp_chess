Class {
	#name : 'MyRandomMoveStrategy',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyRandomMoveStrategy >> chooseMoveFor: aPlayer [

	| pieces |
	pieces := aPlayer king isInCheck
		          ifTrue: [ OrderedCollection with: aPlayer king ]
		          ifFalse: [ aPlayer pieces copy asOrderedCollection ].

	[ pieces notEmpty ] whileTrue: [
		| piece legalMoves |
		piece := pieces atRandom.
		pieces remove: piece.
		legalMoves := piece legalTargetSquares.
		legalMoves ifNotEmpty: [
			^ piece -> legalMoves atRandom ] ].

	^ nil
]
