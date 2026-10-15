Class {
	#name : 'MyRook',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyRook >> blackId [
	^ 'T'
]

{ #category : 'accessing' }
MyRook >> id [
	^ 'R'
]

{ #category : 'rendering' }
MyRook >> targetSquares [

	^ self upFile , self downFile , self leftFile , self rightFile
]

{ #category : 'rendering' }
MyRook >> targetSquaresLegal: aBoolean [

	^ (self upFileLegal: aBoolean) , (self downFileLegal: aBoolean)
	  , (self leftFileLegal: aBoolean) , (self rightFileLegal: aBoolean)
]

{ #category : 'as yet unclassified' }
MyRook >> whiteId [
	^ 'R'
]
