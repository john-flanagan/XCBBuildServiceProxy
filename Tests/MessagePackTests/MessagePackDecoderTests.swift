import Foundation
import XCTest

@testable import MessagePack

struct Subject: Equatable {
    let boolProperty: Bool
    let stringProperty: String
    let unknownProperty: MessagePackValue
}

extension Subject: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        self.boolProperty = try container.decode()
        self.stringProperty = try container.decode()
        self.unknownProperty = try container.decode()

        try container.throwIfNotAtEnd()
    }
}

class MessagePackDecoderTests: XCTestCase {
    func testSimpleDecode() throws {
        let values: [MessagePackValue] = [true, "test", .float(2)]
        
        let subject = try MessagePackDecoder().decode(Subject.self, from: values)
        
        XCTAssertEqual(subject, Subject(boolProperty: true, stringProperty: "test", unknownProperty: .float(2)))
    }
}
