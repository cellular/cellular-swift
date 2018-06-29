import XCTest
@testable import UnitTests

XCTMain([
    testCase(CodableTests.allTests),
    testCase(ResultTests.allTests)
])
