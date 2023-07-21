//
//  JSONDecoder+Extension.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

extension JSONDecoder {
    static func decode<T: Decodable>(
        _ type: T.Type,
        data: Data,
        dateFormatter: DateFormatter = .iso8601Full
    ) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(type, from: data)
    }
}
