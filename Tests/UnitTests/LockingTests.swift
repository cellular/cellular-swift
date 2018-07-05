import XCTest
#if os(Linux)
@testable import Locking
#else
@testable import CELLULAR
#endif

class LockingTests: XCTestCase {

    // Will test blocking mechanism of DispatchLock
    func testDispatchLock() {

        let taskQueue = DispatchQueue(label: "test.tasks.queue", attributes: .concurrent)
        let lockQueue = DispatchQueue(label: "test.lock.queue", attributes: .concurrent)

        let lock = DispatchLock(queue: lockQueue)
        let initialValue = "initial value"
        let protected: Protected<String> = Protected(initialValue: initialValue, lock: lock)

        var completedFirstRead = false
        var completedSecondRead = false
        var completedWrite = false

        let firstReadExpectation = expectation(description: "first.read.expectation")
        taskQueue.async {
            protected.read { value in
                // Make first read a long running task
                sleep(2)
                // Value hasn't not been changed yet
                XCTAssertEqual(initialValue, value)
                XCTAssertTrue(completedSecondRead)

                completedFirstRead = true
                firstReadExpectation.fulfill()
            }
        }

        let secondReadExpectation = expectation(description: "second.read.expectation")
        taskQueue.async {
            protected.read { value in
                // First read task should not be completed yet, because read on DispatchLock is non blocking and thus
                // allows multiple simultanous operations.
                XCTAssertFalse(completedFirstRead)
                XCTAssertEqual(initialValue, value)
                completedSecondRead = true
                secondReadExpectation.fulfill()
            }
        }

        let writeExpectation = expectation(description: "write.expectation")
        let newValue = "new value"
        taskQueue.async {
            protected.write { value in
                // Should only start if all prior tasks on queue are completed
                XCTAssert(completedFirstRead && completedSecondRead)
                // Make write operation a long running task.
                // Write will block future dispatched task on queue until it is completed
                sleep(1)
                value = newValue
                completedWrite = true
                writeExpectation.fulfill()
            }
        }

        let lastReadExpectation = expectation(description: "last.read.expectation")
        taskQueue.async {
            protected.read { value in
                // Should only start if all prior tasks are completed
                XCTAssert(completedFirstRead && completedSecondRead && completedWrite)
                XCTAssertEqual(value, newValue)
                lastReadExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 3) { error in
            if let error = error { XCTFail(error.localizedDescription) }
        }
    }

    // Will test blocking mechanism of NSLock
    func testFoundationLock() {

        let taskQueue = DispatchQueue(label: "test.tasks.queue", attributes: .concurrent)

        let lock = NSLock()
        let initialValue = "initial value"
        let protected: Protected<String> = Protected(initialValue: initialValue, lock: lock)

        var completedFirstRead = false
        var completedSecondRead = false
        var completedWrite = false

        let firstReadExpectation = expectation(description: "first.read.expectation")
        taskQueue.async {
            protected.read { value in
                // Make first read a long running task
                sleep(1)
                XCTAssertEqual(initialValue, value)
                completedFirstRead = true
                firstReadExpectation.fulfill()
            }
        }

        let secondReadExpectation = expectation(description: "second.read.expectation")
        taskQueue.async {
            protected.read { value in
                // First task should be completed due to blocking nature of NSLock for reads and writes.
                XCTAssert(completedFirstRead)
                XCTAssertEqual(initialValue, value)
                completedSecondRead = true
                secondReadExpectation.fulfill()
            }
        }

        let writeExpectation = expectation(description: "write.expectation")
        let newValue = "new value"
        taskQueue.async {
            protected.write { value in
                // Should only start if all prior tasks on queue are completed
                XCTAssert(completedFirstRead && completedSecondRead)
                // Make write operation a long running task. Will block future tasks until it is completed.
                sleep(1)
                value = newValue
                completedWrite = true
                writeExpectation.fulfill()
            }
        }

        let lastReadExpectation = expectation(description: "last.read.expectation")
        taskQueue.async {
            protected.read { value in
                // Should only start if all prior tasks are completed
                XCTAssert(completedFirstRead && completedSecondRead && completedWrite)
                XCTAssertEqual(value, newValue)
                lastReadExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 3) { error in
            if let error = error { XCTFail(error.localizedDescription) }
        }
    }
}

// MARK: - Linux

#if os(Linux)
extension LockingTests {

    public static var allTests = [
        ("testDispatchLock", testDispatchLock),
        ("testFoundationLock", testFoundationLock)
    ]
}
#endif
