Class {
	#name : 'MyPGNFuzzTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'as yet unclassified' }
MyPGNFuzzTest >> parsingFails: aString [

	^ [ MyPGNParser parse: aString. false ] on: Error do: [ :e | true ]
]

{ #category : 'tests' }
MyPGNFuzzTest >> testEmptyPGNDoesNotHang [

	self assert: (self parsingFails: '')
]

{ #category : 'tests' }
MyPGNFuzzTest >> testExamplePGNParses [
	

	self deny: (self parsingFails:
		 '[Event "F"]
[Site "S"]

1. e4 e5 2. Nf3 Nc6 1/2-1/2')
]

{ #category : 'tests' }
MyPGNFuzzTest >> testUnfinishedGameResultCrashes [
	"Bug attendu : '*' fait planter le parseur (notYetImplemented)"

	self assert: (self parsingFails: '1. e4 e5 *')
]
