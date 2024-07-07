//
//  XPagingData.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

struct XPagingData<T: Codable>: Codable {
    let resultCount: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case resultCount, results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resultCount = try container.decode(Int.self, forKey: .resultCount)
        self.results = try container.decode([T].self, forKey: .results)
    }
}
