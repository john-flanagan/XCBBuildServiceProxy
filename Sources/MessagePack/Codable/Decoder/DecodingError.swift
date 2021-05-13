import Foundation

extension DecodingError {
    /// Returns a `.typeMismatch` error describing the expected type.
    ///
    /// - Parameters:
    ///   - path: The path of `CodingKey`s taken to decode a value of this type.
    ///   - expectation: The type expected to be encountered.
    ///   - reality: The value that was encountered instead of the expected type.
    /// - Returns: A `DecodingError` with the appropriate path and debug description.
    public static func typeMismatch(at path: [CodingKey], expectation: Any.Type, reality value: MessagePackValue) -> DecodingError {
        let description = "Expected to decode \(expectation) but found \(value.description) instead."
        return .typeMismatch(expectation, Context(codingPath: path, debugDescription: description))
    }
    
    public static func unknownRawValue<T>(_ rawValue: T, at path: [CodingKey], forType type: Any.Type) -> DecodingError {
        let description = "Unknown rawValue \(rawValue) for type \(type)."
        return .dataCorrupted(DecodingError.Context(codingPath: path, debugDescription: description))
    }
}
