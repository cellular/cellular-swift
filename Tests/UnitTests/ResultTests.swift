import XCTest
@testable import CELLULAR

class ResultTests: XCTestCase {

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

    func testEquatableSuccess() {
        let valueOne = "value"
        let valueTwo = valueOne
        let resultOne: Result<String, String> = .success(valueOne)
        let resultTwo: Result<String, String> = .success(valueTwo)
        XCTAssertTrue(resultOne == resultTwo)
    }

    func testNoneEquatableSuccess() {
        let valueOne = "value"
        let valueTwo = "something different"
        let resultOne: Result<String, String> = .success(valueOne)
        let resultTwo: Result<String, String> = .success(valueTwo)
        XCTAssertFalse(resultOne == resultTwo)
    }

    func testEquatableFailure() {
        let valueOne = "value"
        let valueTwo = valueOne
        let resultOne: Result<String, String> = .failure(valueOne)
        let resultTwo: Result<String, String> = .failure(valueTwo)
        XCTAssertTrue(resultOne == resultTwo)
    }

    func testNoneEquatableFailure() {
        let valueOne = "value"
        let valueTwo = "something different"
        let resultOne: Result<String, String> = .failure(valueOne)
        let resultTwo: Result<String, String> = .failure(valueTwo)
        XCTAssertFalse(resultOne == resultTwo)
    }

    func testUnequalCaseWithEqualModel() {

        // When models are equal, but cases do not match ...
        let valueOne = "value"
        let valueTwo = valueOne
        let resultOne: Result<String, String> = .success(valueOne) // SUCCESS
        let resultTwo: Result<String, String> = .failure(valueTwo) // FAILURE

        // ... they must not be equal
        XCTAssertFalse(resultOne == resultTwo)
    }

    func testUnequalCaseWithEqualModelViceVersa() {

        // When models are equal, but cases do not match ...
        let valueOne = "value"
        let valueTwo = valueOne
        let resultOne: Result<String, String> = .failure(valueOne) // FAILURE
        let resultTwo: Result<String, String> = .success(valueTwo) // SUCCESS

        // ... they must not be equal
        XCTAssertFalse(resultOne == resultTwo)
    }
}

// MARK: - Linux

#if os(Linux)
extension ResultTests {

    public static var allTests = [
        ("testSuccess", testSuccess),
        ("testFailure", testFailure),
        ("testEquatable", testEquatableSuccess),
        ("testEquatableFailure", testEquatableFailure),
        ("testNoneEquatableSuccess", testNoneEquatableSuccess),
        ("testNoneEquatableFailure", testNoneEquatableFailure),
        ("testUnequalCaseWithEqualModel", testUnequalCaseWithEqualModel),
        ("testUnequalCaseWithEqualModelViceVersa", testUnequalCaseWithEqualModelViceVersa)
    ]
}
#endif
