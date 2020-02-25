//
//  TransportTypeTests.swift
//  MapboxDirections
//
//  Created by Sebastian Osiński on 25/02/2020.
//  Copyright © 2020 Mapbox. All rights reserved.
//

import XCTest
@testable import MapboxDirections

class TransportTypeTests: XCTestCase {
    func testDecoding() {
        let examples: [Example<String, TransportType>] = [
            Example("driving", .automobile),
            Example("ferry", .ferry),
            Example("movable bridge", .movableBridge),
            Example("unaccessible", .inaccessible),
            Example("walking", .walking),
            Example("cycling", .cycling),
            Example("train", .train)
        ]

        let decoder = JSONDecoder()

        for example in examples {
            let decoded = try? decoder.decode(
                CodableContainer<TransportType>.self,
                from: jsonData(type: example.input)
            )

            XCTAssertEqual(decoded?.wrapped, example.expected)
        }
    }

    private func jsonData(type: String) -> Data {
        """
        {
            "wrapped": "\(type)"
        }
        """.data(using: .utf8)!
    }
}

private struct Example<Input, Expected> {
    let input: Input
    let expected: Expected

    init(_ input: Input, _ expected: Expected) {
        self.input = input
        self.expected = expected
    }
}

/// Struct for decoding / encoding 'simple' values which can't be standalone decoded / encoded
/// because they're not valid JSON, e.g. enums, strings. numbers etc.
private struct CodableContainer<C: Codable>: Codable {
    let wrapped: C
}
