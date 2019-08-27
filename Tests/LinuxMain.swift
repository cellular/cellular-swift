import XCTest
@testable import CELLULARTests

XCTMain([
    testCase(CodableTests.allTests),
    testCase(LockingTests.allTests),
    testCase(StoryboardTests.allTests)
])
