import XCTest
@testable import Result

class ResultTests: XCTestCase {

    static var allTests = [
        ("testSuccess", testSuccess),
        ("testFailure", testFailure),
        ("testEquatable", testEquatable)
    ]

    func testSuccess() {
        let successValue = "success"
        let result: Result<String, String> = .success(successValue)

        XCTAssert(result.isSuccessful)
        if case let .success(value) = result {
            XCTAssertEqual(value, successValue)
        } else {
            XCTAssertThrowsError("Pattern matching failed")
        }
      }

    func testFailure() {
        let failureValue = "failure"
        let result: Result<String, String> = .failure(failureValue)

        XCTAssertFalse(result.isSuccessful)
        if case let .failure(value) = result {
            XCTAssertEqual(value, failureValue)
        } else {
            XCTAssertThrowsError("Pattern matching failed")
        }
    }

    func testEquatable() {

        let valueOne = "value"
        var valueTwo = valueOne
        var resultOne: Result<String, String> = .success(valueOne)
        var resultTwo: Result<String, String> = .success(valueTwo)
        XCTAssert(resultOne == resultTwo)

        resultOne = .failure(valueOne)
        resultTwo = .failure(valueTwo)
        XCTAssert(resultOne == resultTwo)

        resultOne = .success(valueOne)
        resultTwo = .failure(valueTwo)
        XCTAssertFalse(resultOne == resultTwo)

        resultOne = .failure(valueOne)
        resultTwo = .success(valueTwo)
        XCTAssertFalse(resultOne == resultTwo)

        valueTwo = "something different"
        resultOne = .success(valueOne)
        resultTwo = .success(valueTwo)
        XCTAssertFalse(resultOne == resultTwo)

        resultOne = .failure(valueOne)
        resultTwo = .failure(valueTwo)
        XCTAssertFalse(resultOne == resultTwo)
    }
}
