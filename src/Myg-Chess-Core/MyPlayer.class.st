Class {
	#name : 'MyPlayer',
	#superclass : 'Object',
	#instVars : [
		'color',
		'game',
		'strategy'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPlayer >> black [

	self color: Color black
]

{ #category : 'accessing' }
MyPlayer >> color [

	^ color
]

{ #category : 'accessing' }
MyPlayer >> color: anObject [

	color := anObject
]

{ #category : 'accessing' }
MyPlayer >> game [

	^ game
]

{ #category : 'accessing' }
MyPlayer >> game: anObject [

	game := anObject
]

{ #category : 'testing' }
MyPlayer >> isWhite [
	
	^ color = Color white
]

{ #category : 'accessing' }
MyPlayer >> king [
	
	^ self pieces detect: [ :p | p isKing ]
]

{ #category : 'accessing' }
MyPlayer >> pieces [

	^ game pieces select: [ :p | p notNil and: [ p color = self color ] ]
]

{ #category : 'playing' }
MyPlayer >> play [

	| choice |
	choice := self strategy chooseMoveFor: self.
	choice ifNil: [ ^ self halt: 'NO MOVES AVAILABLE!' ].
	game move: choice key to: choice value
]

{ #category : 'accessing' }
MyPlayer >> strategy [

	^ strategy ifNil: [ strategy := MyRandomMoveStrategy new ]
]

{ #category : 'accessing' }
MyPlayer >> strategy: aStrategy [

	strategy := aStrategy
]

{ #category : 'constants' }
MyPlayer >> white [

	self color: Color white
]
