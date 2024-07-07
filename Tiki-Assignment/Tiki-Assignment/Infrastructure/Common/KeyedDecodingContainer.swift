//
//  KeyedDecodingContainer.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

extension KeyedDecodingContainer {
    func decodex<T>(key: K, defaultValue: T) -> T
        where T : Decodable {
            return (try? decode(T.self, forKey: key)) ?? defaultValue
    }
}
