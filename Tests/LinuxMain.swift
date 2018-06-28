import XCTest
@testable import UnitTests

XCTMain([
    testCase(CodeableTests.allTests),
    testCase(LockingTests.allTests),
    testCase(ResultTests.allTests)
])
