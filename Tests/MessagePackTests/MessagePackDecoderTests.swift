import Foundation
import XCTest

@testable import MessagePack

struct ManualSubject: Equatable {
    let bool: Bool
    let string: String
    let other: MessagePackValue
}

extension ManualSubject: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        self.bool = try container.decode()
        self.string = try container.decode()
        self.other = try container.decode()

        try container.throwIfNotAtEnd()
    }
}

struct AutomaticSubject: Decodable, Equatable {
    let bool: Bool
    let string: String
    let other: MessagePackValue
}

class MessagePackDecoderTests: XCTestCase {
    func testManualDecode() throws {
        let values: [MessagePackValue] = [true, "test", .float(2)]
        
        let subject = try MessagePackDecoder().decode(ManualSubject.self, from: values)
        
        XCTAssertEqual(subject, ManualSubject(bool: true, string: "test", other: .float(2)))
    }

    func testAutomaticDecodeDictionary() throws {
        let value: MessagePackValue = .map([
            .string("bool"): true,
            .string("string"): "test",
            .string("other"): .float(2),
        ])

        let subject = try MessagePackDecoder().decode(AutomaticSubject.self, from: value)

        XCTAssertEqual(subject, AutomaticSubject(bool: true, string: "test", other: .float(2)))
    }

    func testAutomaticDecodeArray() throws {
        let values: [MessagePackValue] = [true, "test", .float(2)]

        let subject = try MessagePackDecoder().decode(AutomaticSubject.self, from: values)

        XCTAssertEqual(subject, AutomaticSubject(bool: true, string: "test", other: .float(2)))
    }

    func testAutomaticDecodeArrayError() throws {
        let values: [MessagePackValue] = [true, "test", .float(2), true]

        XCTAssertThrowsError(
            try MessagePackDecoder().decode(AutomaticSubject.self, from: values)
        ) { error in
            let expectedError = DecodingError.dataCorrupted(.init(
                codingPath: [],
                debugDescription: "Payload contains 4 values, but only 3 coding keys defined."
            ))

            XCTAssertEqual(error as NSError, expectedError as NSError)
        }
    }
}
