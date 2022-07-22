//
//  ReverseWordsCodeTests.swift
//  ReverseWordsCodeTests
//
//  Created by Vladyslav Nhuien on 21.07.2022.
//

import XCTest
@testable import ReverseWordsCode

class ReverseWordsCodeTests: XCTestCase {
    
    var reverser: Reverser!

    override func setUpWithError() throws {
        try super.setUpWithError()
        reverser = Reverser()
    }

    override func tearDownWithError() throws {
        reverser = nil
        try super.tearDownWithError()
    }

    func testReverseWords() throws {
        let string = "Test string"
        let result = reverser.reverse(textToReverse: string)
        XCTAssertEqual(result, "tseT gnirts")
    }
    
    func testReverseNumeral() throws {
        let string = "123465"
        let result = reverser.reverse(textToReverse: string)
        XCTAssertEqual(result, "564321")
    }
    
    func testReverseSymbol() throws {
        let string = "@$!%(!@$*@#!"
        let result = reverser.reverse(textToReverse: string)
        XCTAssertEqual(result, "!#@*$@!(%!$@")
    }
    
    func testReverseCyrillic() throws {
        let string = "Привет мир!"
        let result = reverser.reverse(textToReverse: string)
        XCTAssertEqual(result, "тевирП !рим")
    }
    
    func testReverseLongText() throws {
        let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultrices semper sapien vel semper. Maecenas egestas faucibus pellentesque. Nunc ornare diam a augue lobortis malesuada. Aliquam pulvinar eget mauris sit amet rutrum. Quisque dignissim tortor in justo dapibus lacinia. Donec."
        let result = reverser.reverse(textToReverse: string)
        XCTAssertEqual(result, "meroL muspi rolod tis ,tema rutetcesnoc gnicsipida .tile nI secirtlu repmes neipas lev .repmes saneceaM satsege subicuaf .euqsetnellep cnuN eranro maid a eugua sitrobol .adauselam mauqilA ranivlup tege siruam tis tema .murtur euqsiuQ missingid rotrot ni otsuj subipad .ainical .cenoD")
    }
    
    func testReverseShortText() throws {
        let string = "La vi"
        let result = reverser.reverse(textToReverse: string)
        XCTAssertEqual(result, "aL iv")
    }
}
