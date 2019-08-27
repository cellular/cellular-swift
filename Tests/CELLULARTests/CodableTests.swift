import XCTest
@testable import Codable

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


class CodableTests: XCTestCase {

    static var allTests = [
        ("testSingleDecoding", testSingleDecoding)
    ]

    func testSingleDecoding() {
        let jsonData = """
        {
            "hasRingSystem" : true,
            "numberOfMoons" : 62,
            "distanceFromSun" : 1400,
            "surfacePressure" : null,
            "discoverer" : "Galileo Galilei (The first person to document the existence)",
            "atmosphericComposition" : [
                "Hydrogen",
                "Helium",
                "Methane",
                "Ammonia",
                "Nitrogen",
                "Oxygen"
            ]
        }
        """.data(using: .utf8)!
        XCTAssertNoThrow(try JSONDecoder().decode(Planet.self, from: jsonData))
    }
}
