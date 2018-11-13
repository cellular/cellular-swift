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
        guard allowInvalidElements else { return try decode([T].self, forKey: key) } // Standard decoding on none failable elements
        let optionals = try decode([T?].self, forKey: key) // Decodes each element optionally
        return optionals.compactMap { $0 } // Flatten-out any failed object
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
        guard allowInvalidElements else { return try decodeIfPresent([T].self, forKey: key) } // Standard decoding on none failable elements
        let optionals = try decodeIfPresent([T?].self, forKey: key)
        return optionals?.compactMap { $0 } // Flatten-out any failed object
    }
}
