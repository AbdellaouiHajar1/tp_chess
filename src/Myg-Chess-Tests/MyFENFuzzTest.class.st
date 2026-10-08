Class {
	#name : 'MyFENFuzzTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'as yet unclassified' }
MyFENFuzzTest >> parsingFails: aString [

	^ [ MyFENParser parse: aString. false ] on: Error do: [ :e | true ]
]

{ #category : 'tests' }
MyFENFuzzTest >> testDigitsInRankCrashes [
	"Bug : les chiffres au milieu d'une rangée ('4P3') ne sont pas développés en cases vides"

	self assert: (self parsingFails: 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1')

]

{ #category : 'tests' }
MyFENFuzzTest >> testEnPassantSquareCrashes [
	"Bug : comparaison caractère/nombre cassée, une case comme 'e3' est refusée"

	self assert: (self parsingFails: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq e3 0 1')

]

{ #category : 'tests' }
MyFENFuzzTest >> testInitialPositionParses [

	self deny: (self parsingFails: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
]

{ #category : 'tests' }
MyFENFuzzTest >> testInvalidFENsAreRejected [

	#( ''
	   'xyz'
	   'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP w KQkq - 0 1'
	   'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR/8 w KQkq - 0 1'
	   'rnbqkbnr/ppppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
	   '9/8/8/8/8/8/8/8 w - - 0 1'
	   'x7/8/8/8/8/8/8/8 w - - 0 1'
	   'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR x KQkq - 0 1'
	   'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - abc 1' )
		do: [ :fen |
			self assert: (self parsingFails: fen) description: 'Devrait être refusé : ' , fen ]

]

{ #category : 'tests' }
MyFENFuzzTest >> testParseRank [ [

	| parser rank |
	parser := MyFENParser forString: 'p2rQknB'.
	rank := parser parseRank.
	
	self assert: rank asArray equals: #(
		'Black pawn'
		$2
		'Black rook'
		'White queen'
		'Black king'
		'Black knight'
		'White bishop'
	)
]
]

{ #category : 'tests' }
MyFENFuzzTest >> testPartialCastlingRightsCrashes [
	"Bug : le parseur lit toujours 4 caractères de roque, donc 'Kq' échoue"

	self assert: (self parsingFails: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w Kq - 0 1')

]

{ #category : 'tests' }
MyFENFuzzTest >> testRandomGarbageNeverHangs [

	| alphabet |
	alphabet := 'rnbqkpRNBQKP12345678/ -wKQkq0123456789abcdefgh'.
	1 to: 500 do: [ :i |
		| fen |
		fen := String streamContents: [ :s |
			       (1 to: 80) atRandom timesRepeat: [ s nextPut: alphabet atRandom ] ].
		[ [ MyFENParser parse: fen ] on: Error do: [ :e | nil ] ]
			valueWithin: 1 second
			onTimeout: [ self fail: 'Timeout sur : ' , fen ] ]
]
