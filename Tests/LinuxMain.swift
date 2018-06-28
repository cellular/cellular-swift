import XCTest
@testable import CodableTests
@testable import LockingTests
@testable import ResultTests

XCTMain([
    testCase(CodeableTests.allTests),
    testCase(LockingTests.allTests),
    testCase(ResultTests.allTests),
])
