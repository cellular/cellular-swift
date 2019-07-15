import Foundation

extension KeyedDecodingContainer {

    /// Decodes a sequence of a given type.
    ///
    /// - Parameters:
    ///   - key: The key that the decoded value is associated with.
    ///   - allowInvalidElements: Filter failed elements or fail whole function.
    /// - Returns: An array of the requested type or nil.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
    public func decode<T>(forKey key: K, allowInvalidElements: Bool = false) throws -> [T] where T: Decodable {
        // Standard decoding on none failable elements
        guard allowInvalidElements else {
            return try decode([T].self, forKey: key)
        }

        // Directly read from unkeyed container behind given `key`
        var container = try nestedUnkeyedContainer(forKey: key)
        guard let numberOfElements = container.count else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Container of unknown length")
        }

        // Decodes each element optionally
        return stride(from: 0, to: numberOfElements, by: 1).compactMap({ _ in
            guard !container.isAtEnd else { return nil }
            return try? container.decode(T.self)
        })
    }

    /// Decodes a optional sequence of a given type.
    ///
    /// - Parameters:
    ///   - key: The key that the decoded value is associated with.
    ///   - allowInvalidElements: Filter failed elements or fail whole function.
    /// - Returns: An array of the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
    public func decode<T>(forKey key: K, allowInvalidElements: Bool = false) throws -> [T]? where T: Decodable {
        guard contains(key) else { return nil }
        return try decode(forKey: key, allowInvalidElements: allowInvalidElements) as [T]
    }
}
