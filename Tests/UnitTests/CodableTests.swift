import XCTest
@testable import CELLULAR

class CodableTests: XCTestCase {

    static var allTests = [
        ("testExample", testExample)
    ]

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual("Hello, World!", "Hello, World!")
    }
}

public struct Planet: Codable {

    public var hasRingSystem: Bool

    public var numberOfMoons: Int

    public var distanceFromSun: Float // 10^6 km

    public var surfacePressure: Double? // bars

    public var discoverer: String

    public var atmosphericComposition: [String]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hasRingSystem = try container.decode(forKey: .hasRingSystem) // Bool
        numberOfMoons = try container.decode(forKey: .numberOfMoons) // Int
        distanceFromSun = try container.decode(forKey: .distanceFromSun) // Float
        surfacePressure = try container.decode(forKey: .surfacePressure) // Double
        discoverer = try container.decode(forKey: .discoverer) // String
        atmosphericComposition = try container.decode(forKey: .atmosphericComposition, allowInvalidElements: true) ?? []
    }
}
