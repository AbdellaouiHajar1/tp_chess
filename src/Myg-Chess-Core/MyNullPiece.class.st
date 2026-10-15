Class {
	#name : 'MyNullPiece',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyNullPiece >> color [

	^ nil
]

{ #category : 'testing' }
MyNullPiece >> hasPiece [

	^ false
]

{ #category : 'accessing' }
MyNullPiece >> instance [

	^ self new
]

{ #category : 'rendering' }
MyNullPiece >> renderPieceOn: aSquare [

	^ aSquare color isBlack
		  ifFalse: [ 'z' ]
		  ifTrue: [ 'x' ]
]
