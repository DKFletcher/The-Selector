# Reflector Selector

I developed this app Using the cardeo project as a starting point. It is a school resource for groups to work and learn about their emotions. Over and above the original code a workbook was added; the ability to set your own images; and quite a good print engine (even though I say so myself). the guts of which is listed below:

```swift
//textBody - Interogates the string to be set and the available space to produce an array that has as its first value a string that fits the available space on page. The function needs to return the following format of array:
	//1) ["block"] a block that fits onto the available space of one page.
	//2) ["","block"] a single line block that does not fit onto the current page.
	//3) ["block1","block2"] block1 fits onto the current page, block2 is recursively carried over onto new pages.

	
	
	func textBody3(to oldAnswer: String, for question: String, from start: CGFloat)->[String]{
		var answer = ""
		var onceThru = false
		oldAnswer.components(separatedBy: CharacterSet.newlines).forEach{newline in
			answer+=newline+" "
			if onceThru{
				onceThru = false
				answer = " \n"+answer
			}
		}
		var maxSplits = 1
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let components = answer.components(separatedBy: chararacterSet)
		let words = components.filter { !$0.isEmpty }.count
		var testAnswer = ""
		var remainder = ""
		if !itemToFitPage(top: start, question: question, answer: answer ){
			for _ in 0..<words{
				if let subString = answer.split(separator: " ", maxSplits: maxSplits, omittingEmptySubsequences: false).last{
					maxSplits+=1
					let predicate = String(subString)
					let predicateRange=answer.range(of: predicate)
					testAnswer = answer
					testAnswer.removeSubrange(predicateRange!)
					if !itemToFitPage(top: start, question: question, answer: testAnswer ){
						if let solutionString = answer.split(separator: " ", maxSplits: maxSplits-2, omittingEmptySubsequences: false).last{
							remainder = String(solutionString)
							let predicateRange=answer.range(of: remainder)
							testAnswer = answer
							testAnswer.removeSubrange(predicateRange!)
							break
						}
					}
				}
			}
			return [testAnswer,remainder]
		} else {
			return [answer]
		}
	}



    internal func formatAnswerBook(drawing pdf: UIGraphicsPDFRendererContext, text block: QuestionAnswer)->CGFloat{
        func helper(startPosition: CGFloat,drawingPDF: UIGraphicsPDFRendererContext, qa: QuestionAnswer)->CGFloat{
            var returnPosition = startPosition
            var page = textBody3(to: qa.answer,for: qa.question,from: returnPosition)
            func help1 () -> CGFloat {
                beginPage = true
                returnPosition = TypeSetConstants.header
                return makeBodyItem(top: returnPosition + TypeSetConstants.standardSpacing, answer: page[1], question: qa.question)
            }

            func help2()-> CGFloat{
                returnPosition = makeBodyItem(top: returnPosition + TypeSetConstants.standardSpacing, answer: page[0], question: qa.question)
                beginPage = true
                returnPosition = TypeSetConstants.header
                return helper(startPosition: returnPosition, drawingPDF: drawingPDF, qa: QuestionAnswer(question: "", answer: page[1]))
            }
            return page.count == 2 ? page[0].count == 0 ? help1() : help2() :
                makeBodyItem(top: returnPosition + TypeSetConstants.standardSpacing, answer: page[0], question: qa.question)
        }
        return block.answer.count > 0 ? helper(startPosition: pagePosition, drawingPDF: pdf, qa: block) : blankAnswerBox(qa: block)
    }

``` 
